import 'package:shared_assets/interfaces/i_storage.dart';
import 'package:merchant_app/global/global.dart';

class AppStorageBridge implements IStorage {
  @override
  T? getPref<T>(String key) => getUserPref<T>(key);

  @override
  Future<void> savePref<T>(String key, T value) => saveUserPref<T>(key, value);
}