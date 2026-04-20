import 'package:shared_assets/interfaces/i_storage.dart';
import 'package:rider_app/global/global.dart';

class AppStorageBridge implements IStorage {
  @override
  T? getPref<T>(String key) => getRiderPref<T>(key);

  @override
  Future<void> savePref<T>(String key, T value) => saveRiderPref<T>(key, value);
}