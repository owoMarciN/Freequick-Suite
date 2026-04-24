import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_assets/extensions/extensions.dart';
import 'package:shared_assets/widgets/ui/unified_snackbar.dart';

class ItemState {
  final bool isFavorite;
  final int likes;

  const ItemState({required this.isFavorite, required this.likes});

  static const empty = ItemState(isFavorite: false, likes: 0);
}

Stream<ItemState> itemStateStream(
    String restaurantID, String menuID, String itemID) {
  return FirebaseAuth.instance.authStateChanges().asyncExpand((user) {
    final itemStream = FirebaseFirestore.instance
        .collection('restaurants')
        .doc(restaurantID)
        .collection('menus')
        .doc(menuID)
        .collection('items')
        .doc(itemID)
        .snapshots()
        .map((doc) {
      final likes = (doc.data()?['likes'] ?? 0) as int;
      return likes;
    });

    if (user == null) {
      return itemStream.map((likes) => ItemState(isFavorite: false, likes: likes));
    }

    final favStream = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc(itemID)
        .snapshots()
        .map((doc) => doc.exists);

    return itemStream.asyncExpand((likes) {
      return favStream.map((isFav) => ItemState(isFavorite: isFav, likes: likes));
    });
  });
}

Future<void> toggleFavorite(BuildContext context, String restaurantID,
    String menuID, String itemID) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    unifiedSnackBar(context.l10nCustomer.fav_pleaseLoginFor);
    return;
  }

  // Extract all strings BEFORE any await — context may be invalid after
  final msgRemoved = context.l10nCustomer.fav_removed;
  final msgAdded = context.l10nCustomer.fav_added;
  final msgError = context.l10nCustomer.fav_error_update;

  final favoriteRef = FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('favorites')
      .doc(itemID);

  final itemRef = FirebaseFirestore.instance
      .collection('restaurants')
      .doc(restaurantID)
      .collection('menus')
      .doc(menuID)
      .collection('items')
      .doc(itemID);

  try {
    final favoriteDoc = await favoriteRef.get();
    if (favoriteDoc.exists) {
      await favoriteRef.delete();
      await itemRef.set({'likes': FieldValue.increment(-1)}, SetOptions(merge: true));
      unifiedSnackBar(msgRemoved);
    } else {
      await favoriteRef.set({
        'itemID': itemID,
        'restaurantID': restaurantID,
        'menuID': menuID,
        'addedAt': Timestamp.now(),
      });
      await itemRef.set({'likes': FieldValue.increment(1)}, SetOptions(merge: true));
      unifiedSnackBar(msgAdded);
    }
  } catch (e) {
    debugPrint('Error toggling favorite: $e');
    unifiedSnackBar(msgError);
  }
}