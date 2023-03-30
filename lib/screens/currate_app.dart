import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:currate_app/routes/routes.dart';



class CurrateApp extends StatelessWidget {
  CurrateApp({super.key});
  final GoRouter myRouter = RoutesCurrateApp().router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationProvider: myRouter.routeInformationProvider,
        routeInformationParser: myRouter.routeInformationParser,
        routerDelegate: myRouter.routerDelegate
        );
  }
}
