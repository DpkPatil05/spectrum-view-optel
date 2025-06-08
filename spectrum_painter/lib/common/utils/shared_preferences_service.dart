import '../repositories/shared_preference_repository.dart';

abstract class SharedPreferencesService {
  SharedPreferencesService();

  Future<void> setSharedPrefsData({
    required String key,
    required dynamic value,
  });

  bool? getBoolData(String key);

  int? getIntData(String key);

  double? getDoubleData(String key);

  String? getStringData(String key);

  List<String>? getStringListData(String key);
}

class SharedPreferencesServiceImpl extends SharedPreferencesService {
  SharedPreferencesServiceImpl();

  @override
  Future<void> setSharedPrefsData({
    required String key,
    required dynamic value,
  }) async => await SharedPreferenceRepository.setData(key: key, value: value);

  @override
  bool? getBoolData(String key) => SharedPreferenceRepository.getBool(key);

  @override
  int? getIntData(String key) => SharedPreferenceRepository.getInt(key);

  @override
  double? getDoubleData(String key) =>
      SharedPreferenceRepository.getDouble(key);

  @override
  String? getStringData(String key) =>
      SharedPreferenceRepository.getString(key);

  @override
  List<String>? getStringListData(String key) =>
      SharedPreferenceRepository.getStringList(key);
}
