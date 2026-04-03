import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:user_app/global/global.dart';

class AddressProvider extends ChangeNotifier {
  int _count = -1;
  Map<String, dynamic> _address = {};
  String? _selectedAddressID;
  int _totalSavedAddresses = 0;
  double _lat = 0.0;
  double _lng = 0.0;

  int get count => _count;
  Map<String, dynamic> get address => _address;
  String? get selectedAddressID => _selectedAddressID;
  int get totalSavedAddresses => _totalSavedAddresses;
  double get lat => _lat;
  double get lng => _lng;

  Future<void> displayResult(
    int index, {
    required Map<String, dynamic> address,
    String? addressID,
    double lat = 0.0,
    double lng = 0.0,
  }) async {
    _count             = index;
    _address           = address;
    _selectedAddressID = addressID;
    _lat               = lat;
    _lng               = lng;
    notifyListeners();

    await saveUserPref<int>('address_index', index);
    await saveUserPref<String>('address_map', json.encode(address));
    
    if (addressID != null) {
      await saveUserPref<String>('address_id', addressID);
    }
  }

  Future<void> loadSavedAddress() async {
    _count = getUserPref<int>('address_index') ?? -1;
    _selectedAddressID = getUserPref<String>('address_id');

    final addressJson = getUserPref<String>('address_map');
    _address = addressJson != null
        ? Map<String, dynamic>.from(json.decode(addressJson))
        : {};

    notifyListeners();
  }

  void setTotalSavedAddresses(int total) {
    if (_totalSavedAddresses == total) return;
    _totalSavedAddresses = total;
    notifyListeners();
  }

  void reset() {
    _count             = -1;
    _address           = {};
    _selectedAddressID = null;
    _lat               = 0.0;
    _lng               = 0.0;
    notifyListeners();
  }
}