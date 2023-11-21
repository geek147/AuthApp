import 'package:auth_app_flutter/routes/app_routers.gr.dart';
import 'package:auth_app_flutter/service/user_cache_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../core/service_locator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 2),
      () {
        serviceLocator<UserCacheService>().getUser().then((user) {
          AutoRouter.of(context).pushAndPopUntil(
            user != null ? const HomeRoute() : const RegisterRoute(),
            predicate: (_) => false,
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Auth App',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
