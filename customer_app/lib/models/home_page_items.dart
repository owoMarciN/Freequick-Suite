import 'package:flutter/material.dart';
import 'package:shared_assets/extensions/extensions.dart';

class HomePageItem {
  final String imageUrl;
  final String name;

  const HomePageItem(this.name, this.imageUrl);
}

/// Returns the full localized list
List<List<HomePageItem>> _homePageItems(BuildContext context) {
  final l10n = context.l10nCustomer;

  return [
    [
      HomePageItem(l10n.jalebi, 'images/jalebi.webp'),
      HomePageItem(l10n.kajuBarfi, 'images/kajubarfi.jpeg'),
      HomePageItem(l10n.gulabJamun, 'images/gulabjamun.jpeg'),
      HomePageItem(l10n.softDrinks, 'images/softdrink.png'),
      HomePageItem(l10n.laddoo, 'images/laddoo.jpeg'),
    ],
    [
      HomePageItem(l10n.shake, 'images/shake.jpeg'),
      HomePageItem(l10n.pastries, 'images/pastries.jpeg'),
      HomePageItem(l10n.momos, 'images/momos.jpeg'),
      HomePageItem(l10n.chocolate, 'images/chokolate.jpeg'),
      HomePageItem(l10n.pizza, 'images/pizza1.jpeg'),
    ],
  ];
}

/// Length accessor
int homePageItemsLength(BuildContext context) {
  return _homePageItems(context).length;
}

/// Indexed accessor
List<HomePageItem> getHomePageItems(BuildContext context, int index) {
  final items = _homePageItems(context);

  if (index >= 0 && index < items.length) {
    return items[index];
  }
  return [];
}