import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trinity_wizard/provider/home/home_provider.dart';
import 'package:trinity_wizard/screen/home/home_screen.dart';

GoRouter route = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: HomeScreen.routeName,
  restorationScopeId: HomeScreen.routeName,
  routes: [
    GoRoute(
      path: HomeScreen.routeName,
      name: HomeScreen.routeName,
      builder: (context, state) => ChangeNotifierProvider.value(
        value: HomeProvider(context),
        child: const HomeScreen(),
      ),
    ),
  ],
);
