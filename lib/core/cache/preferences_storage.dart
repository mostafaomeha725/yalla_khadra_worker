import 'package:shared_preferences/shared_preferences.dart';
import 'package:yallakhadra/core/cache/preferences_storage_keys.dart';

class PreferencesStorage {
  final SharedPreferences _preferences;

  PreferencesStorage(this._preferences);

  /// ================= CLEAR =================
  Future<void> clear() async {
    await _preferences.clear();
  }

  /// ================= BOOLEAN =================
  Future<void> putBoolean({
    required PreferencesKeys key,
    required bool value,
  }) async {
    await _preferences.setBool(key.name, value);
  }

  bool getBoolean({required PreferencesKeys key, bool defaultValue = false}) {
    return _preferences.getBool(key.name) ?? defaultValue;
  }

  /// ================= STRING =================
  Future<bool> putString({
    required PreferencesKeys key,
    required String? value,
  }) async {
    return await _preferences.setString(key.name, value ?? "");
  }

  String? getString({required PreferencesKeys key}) {
    return _preferences.getString(key.name);
  }

  Future<void> removeString({required PreferencesKeys key}) async {
    await _preferences.remove(key.name);
  }

  /// ================= TOKEN =================
  Future<void> saveUserToken(String token) async {
    await _preferences.setString(PreferencesKeys.userToken.name, token);
  }

  String? getUserToken() {
    return _preferences.getString(PreferencesKeys.userToken.name);
  }

  Future<void> deleteUserToken() async {
    await _preferences.remove(PreferencesKeys.userToken.name);
  }

  Future<void> saveRefreshToken(String token) async {
    await _preferences.setString(PreferencesKeys.refreshToken.name, token);
  }

  String? getRefreshToken() {
    return _preferences.getString(PreferencesKeys.refreshToken.name);
  }

  Future<void> deleteRefreshToken() async {
    await _preferences.remove(PreferencesKeys.refreshToken.name);
  }

  /// ================= USER PROFILE =================
  Future<void> saveUserProfile({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    await _preferences.setString(PreferencesKeys.firstName.name, firstName);
    await _preferences.setString(PreferencesKeys.lastName.name, lastName);
    await _preferences.setString(PreferencesKeys.email.name, email);
    await _preferences.setString(
      PreferencesKeys.name.name,
      '${firstName.trim()} ${lastName.trim()}'.trim(),
    );
  }

  String getFirstName() {
    return (_preferences.getString(PreferencesKeys.firstName.name) ?? '')
        .trim();
  }

  String getLastName() {
    return (_preferences.getString(PreferencesKeys.lastName.name) ?? '').trim();
  }

  String getEmail() {
    return (_preferences.getString(PreferencesKeys.email.name) ?? '').trim();
  }

  Future<void> clearUserProfile() async {
    await removeString(key: PreferencesKeys.firstName);
    await removeString(key: PreferencesKeys.lastName);
    await removeString(key: PreferencesKeys.name);
    await removeString(key: PreferencesKeys.email);
    await removeString(key: PreferencesKeys.phone);
    await removeString(key: PreferencesKeys.picture);
    await removeString(key: PreferencesKeys.address);
    await _preferences.remove(PreferencesKeys.hasRequestedLocation.name);
  }

  Future<void> setHasRequestedLocation(bool value) async {
    await putBoolean(key: PreferencesKeys.hasRequestedLocation, value: value);
  }

  bool getHasRequestedLocation() {
    return getBoolean(key: PreferencesKeys.hasRequestedLocation, defaultValue: false);
  }

  Future<void> saveUserId(int id) async {
    await _preferences.setString(PreferencesKeys.uuid.name, id.toString());
  }

  int getUserId({int fallback = 3}) {
    final String? raw = _preferences.getString(PreferencesKeys.uuid.name);
    return int.tryParse(raw ?? '') ?? fallback;
  }

  Future<void> saveAddress(String address) async {
    await _preferences.setString(PreferencesKeys.address.name, address);
  }

  String getAddress() {
    return (_preferences.getString(PreferencesKeys.address.name) ?? '').trim();
  }

  /// ================= LANGUAGE =================
  String getCurrentLanguage() {
    return _preferences.getString(PreferencesKeys.currentLanguage.name) ?? "en";
  }

  bool isEnglish() => getCurrentLanguage() == "en";
  bool isArabic() => getCurrentLanguage() == "ar";

  /// ================= CURRENCY =================
  String getCurrentCurrency() {
    return _preferences.getString(PreferencesKeys.currentCurrency.name) ??
        "EGP";
  }

  bool isEGP() => getCurrentCurrency() == "EGP";
  bool isUSD() => getCurrentCurrency() == "USD";
}
