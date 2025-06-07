import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common_constants.dart';

class SharedPreferenceRepository {
  SharedPreferenceRepository._();

  static late SharedPreferences _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setData({
    required String key,
    required dynamic value,
  }) async {
    final dataType = value.runtimeType;
    switch (dataType) {
      case == bool:
        await _sharedPreferences.setBool(key, value);
        break;
      case == String:
        await _sharedPreferences.setString(key, value);
        break;
      case == List:
        await _sharedPreferences.setStringList(key, value);
        break;
      case == int:
        await _sharedPreferences.setInt(key, value);
        break;
      case == double:
        await _sharedPreferences.setDouble(key, value);
        break;
      default:
        debugPrint(CommonConstants.strings.dataTypeNotFound);
    }
  }

  static bool? getBool(String key) => _sharedPreferences.getBool(key);

  static String? getString(String key) => _sharedPreferences.getString(key);

  static List<String>? getStringList(String key) =>
      _sharedPreferences.getStringList(key);

  static int? getInt(String key) => _sharedPreferences.getInt(key);

  static double? getDouble(String key) => _sharedPreferences.getDouble(key);
}
