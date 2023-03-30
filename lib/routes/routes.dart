import 'package:go_router/go_router.dart';

import 'package:currate_app/screens/rate_list/rate_list_screen.dart';
import 'package:currate_app/screens/settings/settings_screen.dart';

class RoutesCurrateApp {
  GoRouter get router => _router;

  final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
          path: '/',
          name: 'rateList',
          builder: (context, state) => RateListScreen(),
          routes: [
            GoRoute(
              path: 'settings',
              name: 'settings',
              builder: (context, state) => SettingsScreen(),
            )
          ]),
    ],
  );
}
