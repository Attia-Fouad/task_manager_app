import 'networks/local/cache_helper.dart';
import 'networks/local/secure_cache_helper.dart';

late bool isLoggedIn;
const double appPadding = 16.0;

Future<String?> getToken() async {
  return await SecureCacheHelper.getData(key: 'token');
}

Future<String?> getRefreshToken() async {
  return await SecureCacheHelper.getData(key: 'refreshToken');
}

Future<void> saveToken({required String token}) async {
  await SecureCacheHelper.saveData(key: 'token', value: token);
  await checkLoginStatus();
}

Future<void> saveRefreshToken({required String token}) async {
  await SecureCacheHelper.saveData(key: 'refreshToken', value: token);
}

Future<void> removeToken() async {
  await SecureCacheHelper.removeData(key: 'token');
  await checkLoginStatus();
}

Future<void> removeRefreshToken() async {
  await SecureCacheHelper.removeData(key: 'refreshToken');
}

Future<void> checkLoginStatus() async {
  isLoggedIn = await getToken() != null ? true : false;
}

Future<bool> checkIsFirstTime() async {
  return await CacheHelper.getData(key: 'isFirstTime') == null ? true : false;
}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}
