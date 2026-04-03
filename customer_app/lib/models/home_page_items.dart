class HomePageItem {
  final String imageUrl;
  final String name;

  const HomePageItem(this.name, this.imageUrl);
}

int homePageItemsLenght() {
  return homePageItems.length;
}

List<HomePageItem> getHomePageItems(int index) {
  if (index >= 0 && index < homePageItems.length) {
    return homePageItems[index];
  }
  return [];
}

List<List<HomePageItem>> homePageItems = [
  [
    HomePageItem('Jalebi', 'images/jalebi.webp'),
    HomePageItem('Kaju Barfi', 'images/kajubarfi.jpeg'),
    HomePageItem('Gulab Jamun', 'images/gulabjamun.jpeg'),
    HomePageItem('Soft Drinks', 'images/softdrink.png'),
    HomePageItem('Laddoo', 'images/laddoo.jpeg'),
  ],
  [
    HomePageItem('Shake', 'images/shake.jpeg'),
    HomePageItem('Pastries', 'images/pastries.jpeg'),
    HomePageItem('Momos', 'images/momos.jpeg'),
    HomePageItem('Chocolate', 'images/chokolate.jpeg'),
    HomePageItem('Pizza', 'images/pizza1.jpeg'),
  ],
];