import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:user_app/providers/cart_provider.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/widgets/ui/unified_snackbar.dart';
import 'package:user_app/extensions/context_translate_ext.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

List<String> separateItemIDs(List<dynamic> userCart) {
  return userCart.map((item) {
    List<String> parts = item.toString().split(':');
    return parts.length >= 3 ? parts[2] : '';
  }).toList();
}

List<int> separateItemQuantities(List<dynamic> userCart) {
  return userCart.map((item) {
    List<String> parts = item.toString().split(':');
    return parts.length >= 4 ? int.parse(parts[3]) : 1;
  }).toList();
}

Future<void> addItemToCart(String? itemID, String? menuID, String? restaurantID,
    BuildContext context, int itemCounter) async {
  final String uid = firebaseAuth.currentUser!.uid;
  final cartRef = FirebaseFirestore.instance
      .collection("users")
      .doc(uid)
      .collection("carts");

  var existingCart = await cartRef.get();
  if (existingCart.docs.isNotEmpty) {
    String storeInCart = existingCart.docs.first.get("restaurantID");
    if (storeInCart != restaurantID) {
      unifiedSnackBar("You can only order from one restuarant at a time.");
      return;
    }
  }

  await cartRef.doc(itemID).set({
    "itemID": itemID,
    "menuID": menuID,
    "restaurantID": restaurantID,
    "quantity": itemCounter,
    "createdAt": DateTime.now(),
  }).then((value) {
    List<String> tempCartList = getUserPref<List<String>>("userCart") ?? [];

    String cartItem = "$restaurantID:$menuID:$itemID:$itemCounter";

    tempCartList
        .removeWhere((item) => item.contains("$restaurantID:$menuID:$itemID:"));

    tempCartList.add(cartItem);

    saveUserPref<List<String>>("userCart", tempCartList);

    unifiedSnackBar("Item Added Successfully.");

    Provider.of<CartProvider>(context, listen: false).loadCart();
  });
}

Future<void> clearCartNow(BuildContext context) async {
  final User? currentUser = firebaseAuth.currentUser;

  if (currentUser == null) {
    unifiedSnackBar("User not logged in.");
    return;
  }

  final String uid = currentUser.uid;

  try {
    var snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("carts")
        .get();
    if (snapshot.docs.isEmpty) {
      unifiedSnackBar("Cart is already empty.");
      return;
    }

    WriteBatch batch = FirebaseFirestore.instance.batch();

    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
    saveUserPref<List<String>>("userCart", []);

    if (context.mounted) {
      Provider.of<CartProvider>(context, listen: false).loadCart();
      unifiedSnackBar("Cart Cleared.");
    }
  } catch (e) {
    unifiedSnackBar("Error clearing cart: $e", error: true);
  }
}

Future<void> removeItemFromCart(BuildContext context, String itemID) async {
  final User? currentUser = firebaseAuth.currentUser;

  if (currentUser == null) {
    unifiedSnackBar("User not logged in.");
    return;
  }

  final String uid = currentUser.uid;

  try {
    var snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("carts")
        .where("itemID", isEqualTo: itemID)
        .limit(1)
        .get();
    if (snapshot.docs.isEmpty) {
      unifiedSnackBar("Item not found in cart.");
      return;
    }

    await snapshot.docs.first.reference.delete();

    List<String>? userCart = getUserPref<List<String>>("userCart");
    if (userCart != null) {
      userCart.removeWhere((item) => item.startsWith("$itemID:"));
      saveUserPref<List<String>>("userCart", userCart);
    }

    if (context.mounted) {
      Provider.of<CartProvider>(context, listen: false).loadCart();
      unifiedSnackBar("Item removed from cart.");
    }
  } catch (e) {
    unifiedSnackBar("Error removing item: $e");
  }
}

Future<void> incrementCartItemQuantity(
    BuildContext context, String itemID) async {
  final User? currentUser = firebaseAuth.currentUser;
  if (currentUser == null) return;

  try {
    var snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .collection("carts")
        .where("itemID", isEqualTo: itemID)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return;

    final doc = snapshot.docs.first;
    final int currentQuantity = doc.get("quantity") ?? 1;

    if (currentQuantity >= 9) {
      unifiedSnackBar("Maximum quantity reached");
      return;
    }

    final int newQuantity = currentQuantity + 1;
    await doc.reference.update({"quantity": newQuantity});

    // Update local pref
    List<String>? userCart = getUserPref<List<String>>("userCart");
    if (userCart != null) {
      final String restaurantID = doc.get("restaurantID");
      final String menuID = doc.get("menuID");
      userCart.removeWhere(
          (item) => item.contains("$restaurantID:$menuID:$itemID:"));
      userCart.add("$restaurantID:$menuID:$itemID:$newQuantity");
      saveUserPref<List<String>>("userCart", userCart);
    }

    if (context.mounted) {
      Provider.of<CartProvider>(context, listen: false).loadCart();
    }
  } catch (e) {
    unifiedSnackBar("Error updating quantity: $e");
  }
}

Future<void> decrementCartItemQuantity(
    BuildContext context, String itemID) async {
  final User? currentUser = firebaseAuth.currentUser;
  if (currentUser == null) return;

  try {
    var snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .collection("carts")
        .where("itemID", isEqualTo: itemID)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) return;

    final doc = snapshot.docs.first;
    final int currentQuantity = doc.get("quantity") ?? 1;

    if (currentQuantity <= 1) {
      return;
    }

    final int newQuantity = currentQuantity - 1;
    await doc.reference.update({"quantity": newQuantity});

    // Update local pref
    List<String>? userCart = getUserPref<List<String>>("userCart");
    if (userCart != null) {
      final String restaurantID = doc.get("restaurantID");
      final String menuID = doc.get("menuID");
      userCart.removeWhere(
          (item) => item.contains("$restaurantID:$menuID:$itemID:"));
      userCart.add("$restaurantID:$menuID:$itemID:$newQuantity");
      saveUserPref<List<String>>("userCart", userCart);
    }

    if (context.mounted) {
      Provider.of<CartProvider>(context, listen: false).loadCart();
    }
  } catch (e) {
    unifiedSnackBar("Error updating quantity: $e", error: true);
  }
}

/// Reformat timestamps to a readable string
String dateTimeToString(BuildContext context, DateTime dt) {
  final now = DateTime.now();
  final diff = now.difference(dt);
  if (diff.inMinutes < 1) return context.l10n.time_just_now;
  if (diff.inMinutes < 60) {
    return context.l10n.time_minutes(diff.inMinutes);
  }
  if (diff.inHours < 24) return context.l10n.time_hours(diff.inHours);
  return '${dt.day.toString().padLeft(2, '0')}.${dt.month.toString().padLeft(2, '0')}';
}

DateTime? timestampToDateTimeTime(dynamic raw) {
  if (raw is Timestamp) return raw.toDate();
  if (raw is DateTime) return raw;
  return null;
}

String formatPhoneNumber(String? raw) {
  if (raw == null || raw.isEmpty) return 'No phone';
  try {
    // Use formatNumberSync for immediate UI feedback
    return formatNumberSync(raw);
  } catch (e) {
    return raw; // Fallback to raw if it can't be parsed
  }
}

String formatPayment(dynamic p) {
  if (p == null) return "Unknown";
  final s = p.toString();
  if (s == "cash") return "Cash on Delivery";
  if (s.toLowerCase().contains("stripe") || s.toLowerCase().contains("card")) {
    return "Card (Stripe)";
  }
  return s;
}

double roundToTwo(double value) {
  // Rounds 1.2345 to 1.23 and 1.235 to 1.24
  return double.parse(value.toStringAsFixed(2));
}

Future<List<Map<String, dynamic>>> fetchItems(
    List<String> itemIDs, String restID) async {
  final List<Map<String, dynamic>> results = [];

  for (String id in itemIDs) {
    try {
      // Because menuID is missing from your DB, we search all 'items' subcollections for this itemID
      final querySnap = await FirebaseFirestore.instance
          .collectionGroup('items')
          .where('itemID', isEqualTo: id)
          .limit(1)
          .get();

      if (querySnap.docs.isNotEmpty) {
        final doc = querySnap.docs.first;
        Map<String, dynamic> data = doc.data();

        // Inject the IDs back into the data map so ItemDetailsScreen has what it needs
        data['itemID'] = doc.id;
        data['restaurantID'] = restID;

        // We can dynamically extract the missing menuID directly from the Firestore path!
        // Path format: restaurants/restID/menus/menuID/items/itemID
        final pathSegments = doc.reference.path.split('/');
        if (pathSegments.length >= 4) {
          data['menuID'] = pathSegments[3];
        }

        results.add(data);
      }
    } catch (e) {
      debugPrint("Error fetching item: $e");
    }
  }
  return results;
}
