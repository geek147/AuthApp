import 'package:auth_app_flutter/db/db_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/user_cache_service.dart';

final serviceLocator = GetIt.instance;
Future<void> setUpServiceLocator() async {
  serviceLocator.registerSingleton<DbHelper>(DbHelper());
  serviceLocator.registerSingleton<UserCacheService>(UserCacheService());
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerFactory<SharedPreferences>(() => sharedPreferences);
}
