import 'dart:convert';

import 'package:auth_app_flutter/core/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';

const String userCacheKey = 'usercache';

class UserCacheService {
  UserModel? _user;
  UserModel? get user => _user;
  SharedPreferences get sharedPrefs => serviceLocator<SharedPreferences>();
  Future<bool> saveUser(UserModel user) async {
    var map = user.toMap();
    bool saved = await sharedPrefs.setString(userCacheKey, jsonEncode(map));
    if (saved) {
      _user = await getUser();
    }
    return saved;
  }

  Future<UserModel?> getUser() async {
    UserModel usr;
    var userMap = sharedPrefs.getString(userCacheKey);
    if (userMap == null) {
      return null;
    }
    usr = UserModel.fromMap(jsonDecode(userMap));
    _user = usr;
    return usr;
  }

  Future<bool> deleteUser() async {
    _user = null;
    return await sharedPrefs.remove(userCacheKey);
  }
}
