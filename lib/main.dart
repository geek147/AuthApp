import 'package:auth_app_flutter/bloc/auth_bloc.dart';
import 'package:auth_app_flutter/core/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'routes/app_routers.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await setUpServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final appRouter = FlutterRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Stealth Auth',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
      ),
    );
  }
}
