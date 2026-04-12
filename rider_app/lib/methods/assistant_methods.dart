import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/extensions/extensions_import.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

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
