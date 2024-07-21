import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../page/add/add_todo_screen.dart';
import '../page/home/home_screen.dart';
import 'app_route.dart';

final GoRouter goRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: Routes.homeScreen,
      builder: (BuildContext context, GoRouterState state) {
        return HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: Routes.addScreen,
          builder: (BuildContext context, GoRouterState state) {
            return const AddTodoScreen();
          },
        ),
      ],
    ),
  ],
);
