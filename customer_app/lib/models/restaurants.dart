class Restaurants {
  String? restaurantID;
  String? name;
  String? businessMobile;
  String? logoUrl;
  String? bannerUrl;
  String? address;
  String? status;
  double? avgRating;
  double? lat;
  double? lng;

  Restaurants({
    required this.restaurantID,
    required this.name,
    required this.businessMobile,
    required this.logoUrl,
    required this.bannerUrl,
    required this.address,
    required this.status,
    required this.avgRating,
    required this.lat,
    required this.lng,
  });

  Restaurants.fromJson(Map<String, dynamic> json) {
    restaurantID = json["restaurantID"];
    name = json["name"];
    businessMobile = json["businessMobile"];
    logoUrl = json["logoUrl"];
    bannerUrl = json["bannerUrl"];
    address = json["address"];
    status = json["status"];
    avgRating = json["avgRating"]?.toDouble();
    lat = json["lat"]?.toDouble();
    lng = json["lng"]?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["restaurantID"] = restaurantID;
    data["name"] = name;
    data["businessMobile"] = businessMobile;
    data["logoUrl"] = logoUrl;
    data["bannerUrl"] = bannerUrl;
    data["address"] = address;
    data["status"] = status;
    data["avgRating"] = avgRating;
    data["lat"] = lat;
    data["lng"] = lng;
    return data;
  }
}