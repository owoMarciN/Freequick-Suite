import 'package:flutter/material.dart';
import 'package:shared_assets/extensions/extensions.dart';

class SearchTab {
  final String label;

  SearchTab({required this.label});
}

List<SearchTab> getSearchTabs(BuildContext context) {
  final t = context.l10nCommon;
  return [
    SearchTab(label: t.all),
    SearchTab(label: t.restaurants),
    SearchTab(label: t.food),
    SearchTab(label: t.stores),
  ];
}
