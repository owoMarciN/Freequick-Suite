import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:shared_assets/widgets/ui/unified_snackbar.dart';
import 'package:user_app/providers/cart_provider.dart';
import 'package:user_app/global/global.dart';
import 'package:shared_assets/extensions/extensions.dart';

// Core Cart Functions
Future<void> addItemToCart(String? itemID, String? menuID, String? restaurantID,
    BuildContext context, int itemCounter) async {
  final customer = context.l10nCustomer;
  final String uid = firebaseAuth.currentUser!.uid;
  
  final cartRef = FirebaseFirestore.instance
      .collection("users")
      .doc(uid)
      .collection("carts");

  // Validate single restaurant restriction
  var existingCart = await cartRef.limit(1).get();
  if (existingCart.docs.isNotEmpty) {
    String storeInCart = existingCart.docs.first.get("restaurantID");
    if (storeInCart != restaurantID) {
      unifiedSnackBar(customer.cartSingleRestaurantError);
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

    // Clean existing entry for this specific item before adding new quantity
    tempCartList.removeWhere((item) => item.contains(":$itemID:"));
    tempCartList.add(cartItem);

    saveUserPref<List<String>>("userCart", tempCartList);
    unifiedSnackBar(customer.cartItemAdded);
    Provider.of<CartProvider>(context, listen: false).loadCart();
  });
}

Future<void> clearCartNow(BuildContext context) async {
  final customer = context.l10nCustomer;
  final User? currentUser = firebaseAuth.currentUser;

  if (currentUser == null) return;
  final String uid = currentUser.uid;

  try {
    var snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("carts")
        .get();
        
    if (snapshot.docs.isEmpty) return;

    WriteBatch batch = FirebaseFirestore.instance.batch();
    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
    saveUserPref<List<String>>("userCart", []);

    if (context.mounted) {
      Provider.of<CartProvider>(context, listen: false).loadCart();
      unifiedSnackBar(customer.cartCleared);
    }
  } catch (e) {
    unifiedSnackBar(e.toString(), error: true);
  }
}

Future<void> removeItemFromCart(BuildContext context, String itemID) async {
  final customer = context.l10nCustomer;
  final User? currentUser = firebaseAuth.currentUser;
  if (currentUser == null) return;

  try {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .collection("carts")
        .doc(itemID)
        .delete();

    List<String> userCart = getUserPref<List<String>>("userCart") ?? [];
    userCart.removeWhere((item) => item.contains(":$itemID:"));
    saveUserPref<List<String>>("userCart", userCart);

    if (context.mounted) {
      Provider.of<CartProvider>(context, listen: false).loadCart();
      unifiedSnackBar(customer.cartItemRemoved);
    }
  } catch (e) {
    unifiedSnackBar(e.toString(), error: true);
  }
}

Future<void> incrementCartItemQuantity(BuildContext context, String itemID) async {
  final customer = context.l10nCustomer;
  final User? currentUser = firebaseAuth.currentUser;
  if (currentUser == null) return;

  try {
    final docRef = FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .collection("carts")
        .doc(itemID);

    final doc = await docRef.get();
    if (!doc.exists) return;

    final int currentQuantity = doc.get("quantity") ?? 1;
    if (currentQuantity >= 9) {
      unifiedSnackBar(customer.cartMaxQuantityReached);
      return;
    }

    final int newQuantity = currentQuantity + 1;
    await docRef.update({"quantity": newQuantity});

    _updateLocalQuantity(itemID, newQuantity, doc.get("restaurantID"), doc.get("menuID"));

    if (context.mounted) {
      Provider.of<CartProvider>(context, listen: false).loadCart();
    }
  } catch (e) {
    unifiedSnackBar(e.toString(), error: true);
  }
}

Future<void> decrementCartItemQuantity(BuildContext context, String itemID) async {
  final User? currentUser = firebaseAuth.currentUser;
  if (currentUser == null) return;

  try {
    final docRef = FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .collection("carts")
        .doc(itemID);

    final doc = await docRef.get();
    if (!doc.exists) return;

    final int currentQuantity = doc.get("quantity") ?? 1;
    if (currentQuantity <= 1) return;

    final int newQuantity = currentQuantity - 1;
    await docRef.update({"quantity": newQuantity});

    _updateLocalQuantity(itemID, newQuantity, doc.get("restaurantID"), doc.get("menuID"));

    if (context.mounted) {
      Provider.of<CartProvider>(context, listen: false).loadCart();
    }
  } catch (e) {
    unifiedSnackBar(e.toString(), error: true);
  }
}

// Private helper to keep SharedPreferences in sync
void _updateLocalQuantity(String itemID, int newQty, String restID, String menuID) {
  List<String> userCart = getUserPref<List<String>>("userCart") ?? [];
  userCart.removeWhere((item) => item.contains(":$itemID:"));
  userCart.add("$restID:$menuID:$itemID:$newQty");
  saveUserPref<List<String>>("userCart", userCart);
}

// Data Fetching
Future<List<Map<String, dynamic>>> fetchItems(List<String> itemIDs, String restID) async {
  final List<Map<String, dynamic>> results = [];

  for (String id in itemIDs) {
    try {
      final querySnap = await FirebaseFirestore.instance
          .collectionGroup('items')
          .where('itemID', isEqualTo: id)
          .limit(1)
          .get();

      if (querySnap.docs.isNotEmpty) {
        final doc = querySnap.docs.first;
        Map<String, dynamic> data = doc.data();

        data['itemID'] = doc.id;
        data['restaurantID'] = restID;

        // Extract menuID from: restaurants/{restID}/menus/{menuID}/items/{itemID}
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