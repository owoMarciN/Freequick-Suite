import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_assets/extensions/extensions.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// Deletes a file from Firebase Storage given its URL.
/// Returns a [String?] containing an error message if it fails, or null if successful.
Future<String?> deleteOldFile(String url) async {
  if (url.isEmpty || !url.contains('firebasestorage')) return null;

  try {
    await FirebaseStorage.instance.refFromURL(url).delete();
    return null; // Success
  } on FirebaseException catch (e) {
    // 1. Silent ignore for already deleted files
    if (e.code == 'object-not-found') {
      return null;
    }

    // 2. Handle specific UI-friendly errors
    if (e.code == 'permission-denied') {
      return "You don't have permission to edit this.";
    }
    if (e.code == 'network-request-failed') {
      return "Check your internet connection.";
    }

    // 3. Fallback for other Firebase errors
    return "Storage error: ${e.message}";
  } catch (e) {
    // 4. Catch-all for non-Firebase exceptions
    return "An unexpected error occurred.";
  }
}

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

double roundToTwo(double value) {
  // Rounds 1.2345 to 1.23 and 1.235 to 1.24
  return double.parse(value.toStringAsFixed(2));
}

String formatPhoneNumber(BuildContext context, String? raw) {
  if (raw == null || raw.isEmpty) return context.l10nCommon.errorNoPhone;
  try {
    return formatNumberSync(raw);
  } catch (e) {
    return raw;
  }
}

String formatPayment(BuildContext context, dynamic p) {
  final t = context.l10nCommon;
  if (p == null) return t.unknown;
  final s = p.toString().toLowerCase();
  if (s == "cash") return t.payment_cash;
  if (s.contains("stripe") || s.contains("card")) return t.payment_stripe;
  return s;
}

String dateTimeToString(BuildContext context, DateTime dt) {
  final now = DateTime.now();
  final diff = now.difference(dt);

  if (diff.inMinutes < 1) return context.l10nCommon.time_just_now;
  if (diff.inMinutes < 60)
    return context.l10nCommon.time_minutes(diff.inMinutes);
  if (diff.inHours < 24) return context.l10nCommon.time_hours(diff.inHours);

  return context.l10nCommon.time_date_format(
    dt.day.toString().padLeft(2, '0'),
    dt.month.toString().padLeft(2, '0'),
  );
}

DateTime? timestampToDateTime(dynamic raw) {
  if (raw is Timestamp) return raw.toDate();
  if (raw is DateTime) return raw;
  return null;
}