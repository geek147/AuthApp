import 'package:auth_app_flutter/model/user.dart';
import 'package:auth_app_flutter/service/user_cache_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';
import '../core/service_locator.dart';
import '../routes/app_routers.gr.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home-page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        serviceLocator<UserCacheService>().getUser().then((user) {
          setState(() {
            userModel = user;
          });
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is AuthInitial) {
        AutoRouter.of(context).pushAndPopUntil(
          const LoginRoute(),
          predicate: (_) => false,
        );
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Auth App'),
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                context.read<AuthBloc>().add(
                      SignOutEvent(),
                    );
              },
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome \n${userModel?.userName}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 38,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
