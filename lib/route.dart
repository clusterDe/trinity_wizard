import 'package:go_router/go_router.dart';
import 'package:trinity_wizard/screen/home/home_screen.dart';

GoRouter route = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: HomeScreen.routeName,
  restorationScopeId: HomeScreen.routeName,
  routes: [
    GoRoute(
      path: HomeScreen.routeName,
      name: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
