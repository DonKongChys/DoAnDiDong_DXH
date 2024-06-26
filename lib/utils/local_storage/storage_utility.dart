import 'package:get_storage/get_storage.dart';

class TLocalStorage {

  late final GetStorage _storage;

  // Singleton instance
  static TLocalStorage? _instance;

  TLocalStorage._internal();

  factory TLocalStorage.instance(){
    _instance ??= TLocalStorage._internal();
    return _instance!;
  }

  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance = TLocalStorage._internal();
    _instance!._storage = GetStorage(bucketName);
  }

  // Generic method to save data
  Future<void> writeData<T>(String key, T value) async{
    return _storage.write(key, value);
  }
  // Genericmethod to read data
  T? readData<T>(String key) {
    return _storage.read(key);
  }
  // Generic method to remove data
  Future<void> removeData<T>(String key) async{
    return _storage.remove(key);
  }

  // static final TLocalStorage instance = TLocalStorage._internal();

  // factory TLocalStorage() => instance;

  // TLocalStorage._internal();

  // final _storage = GetStorage();

  // // Generic method to save data
  // Future<void> saveData<T>(String key, T value) async {
  //   await _storage.write(key, value);
  // }

  // // Generic method to read data
  // T? readData<T>(String key) {
  //   return _storage.read<T>(key);
  // }

  // Future<void> removeData(String key) async {
  //   await _storage.remove(key);
  // }

  // Future<void> clearAll() async {
  //   await _storage.erase();
  // }
}
