abstract class IStorage {
  Future<void> savePref<T>(String key, T value);
  T? getPref<T>(String key);
}