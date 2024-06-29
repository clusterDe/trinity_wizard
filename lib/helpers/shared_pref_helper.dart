import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  // ------------------- DATA STRING --------------------------

  static Future<bool> writeDataString(
      {required String keyName, required String dataName}) async {
    var instance = await SharedPreferences.getInstance();
    var result = await instance.setString(keyName, dataName);

    return result;
  }

  static Future<String?> readDataString({required String keyName}) async {
    var instance = await SharedPreferences.getInstance();
    var result = instance.getString(keyName);

    return result;
  }

  static Future<bool> writeDataStringList({
    required String keyName,
    required List<String> dataName,
  }) async {
    var instance = await SharedPreferences.getInstance();
    var result = await instance.setStringList(keyName, dataName);

    return result;
  }

  static Future<List<String>?> readDataStringList({
    required String keyName,
  }) async {
    var instance = await SharedPreferences.getInstance();
    var result = instance.getStringList(keyName);

    return result;
  }

  // ------------------- DATA BOOL --------------------------

  static Future<bool> writeDataBool(
      {required String keyName, required bool dataBool}) async {
    var instance = await SharedPreferences.getInstance();
    var result = await instance.setBool(keyName, dataBool);

    return result;
  }

  static Future<bool?> readDataBool({required String keyName}) async {
    var instance = await SharedPreferences.getInstance();
    var result = instance.getBool(keyName);

    return result;
  }

  // ------------------- DATA INT --------------------------

  static Future<bool> writeDataInt(
      {required String keyName, required int dataInt}) async {
    var instance = await SharedPreferences.getInstance();
    var result = await instance.setInt(keyName, dataInt);

    return result;
  }

  static Future<int?> readDataInt({required String keyName}) async {
    var instance = await SharedPreferences.getInstance();
    var result = instance.getInt(keyName);

    return result;
  }

  // ------------------- REMOVE DATA --------------------------

  static Future<bool> removeData({required String keyName}) async {
    var instance = await SharedPreferences.getInstance();
    var result = await instance.remove(keyName);

    return result;
  }
}
