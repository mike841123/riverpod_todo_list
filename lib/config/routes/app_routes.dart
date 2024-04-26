import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/config/routes/routes_location.dart';
import 'package:todo_list/config/routes/routes_provider.dart';

import '../../screens/create_task_screen.dart';
import '../../screens/home_screen.dart';

final appRoutes = [
  GoRoute(
    path: RouteLocation.home,
    parentNavigatorKey: navigationKey,
    builder: (BuildContext context, GoRouterState state) {
      return const HomeScreen();
    },
  ),
  GoRoute(
    path: RouteLocation.createTask,
    parentNavigatorKey: navigationKey,
    builder: (BuildContext context, GoRouterState state) {
      return const CreateTaskScreen();
    },
  ),
];
