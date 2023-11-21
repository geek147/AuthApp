import 'package:auth_app_flutter/page/home_page.dart';
import 'package:auth_app_flutter/page/login_page.dart';
import 'package:auth_app_flutter/page/otp_page.dart';
import 'package:auth_app_flutter/page/register_page.dart';
import 'package:auth_app_flutter/page/splash_page.dart';
import 'package:auto_route/auto_route.dart';

@MaterialAutoRouter(
  routes: [
    AutoRoute<bool>(page: SplashPage, initial: true),
    AutoRoute<bool>(page: RegisterPage, path: RegisterPage.routeName),
    AutoRoute<bool>(page: HomePage, path: HomePage.routeName),
    AutoRoute<bool>(page: LoginPage, path: LoginPage.routeName),
    AutoRoute<bool>(page: OtpPage, path: OtpPage.routeName),
  ],
  replaceInRouteName: 'Page,Route',
)
class $FlutterRouter {}
