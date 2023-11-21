// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../page/home_page.dart' as _i3;
import '../page/login_page.dart' as _i4;
import '../page/otp_page.dart' as _i5;
import '../page/register_page.dart' as _i2;
import '../page/splash_page.dart' as _i1;

class FlutterRouter extends _i6.RootStackRouter {
  FlutterRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i6.MaterialPageX<bool>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i6.MaterialPageX<bool>(
        routeData: routeData,
        child: const _i2.RegisterPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.MaterialPageX<bool>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i6.MaterialPageX<bool>(
        routeData: routeData,
        child: const _i4.LoginPage(),
      );
    },
    OtpRoute.name: (routeData) {
      final args = routeData.argsAs<OtpRouteArgs>();
      return _i6.MaterialPageX<bool>(
        routeData: routeData,
        child: _i5.OtpPage(
          key: args.key,
          userName: args.userName,
          email: args.email,
          password: args.password,
        ),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i6.RouteConfig(
          RegisterRoute.name,
          path: '/register-page',
        ),
        _i6.RouteConfig(
          HomeRoute.name,
          path: '/home-page',
        ),
        _i6.RouteConfig(
          LoginRoute.name,
          path: '/login-page',
        ),
        _i6.RouteConfig(
          OtpRoute.name,
          path: '/otp-page',
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i6.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.RegisterPage]
class RegisterRoute extends _i6.PageRouteInfo<void> {
  const RegisterRoute()
      : super(
          RegisterRoute.name,
          path: '/register-page',
        );

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home-page',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login-page',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i5.OtpPage]
class OtpRoute extends _i6.PageRouteInfo<OtpRouteArgs> {
  OtpRoute({
    _i7.Key? key,
    required String userName,
    required String email,
    required String password,
  }) : super(
          OtpRoute.name,
          path: '/otp-page',
          args: OtpRouteArgs(
            key: key,
            userName: userName,
            email: email,
            password: password,
          ),
        );

  static const String name = 'OtpRoute';
}

class OtpRouteArgs {
  const OtpRouteArgs({
    this.key,
    required this.userName,
    required this.email,
    required this.password,
  });

  final _i7.Key? key;

  final String userName;

  final String email;

  final String password;

  @override
  String toString() {
    return 'OtpRouteArgs{key: $key, userName: $userName, email: $email, password: $password}';
  }
}
