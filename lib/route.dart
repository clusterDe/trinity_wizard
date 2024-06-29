import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:trinity_wizard/model/contact/contact_model.dart';
import 'package:trinity_wizard/provider/detail_contact/detail_contact_provider.dart';
import 'package:trinity_wizard/provider/home/home_provider.dart';
import 'package:trinity_wizard/screen/detail_contact/detail_contact_screen.dart';
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
        routes: [
          GoRoute(
            path: DetailContactScreen.routeName,
            name: DetailContactScreen.routeName,
            builder: (context, state) {
              var extra = state.extra;

              if (extra is ContactModel) {
                return ChangeNotifierProvider.value(
                  value: DetailContactProvider(
                    context,
                    contact: extra,
                  ),
                  child: const DetailContactScreen(),
                );
              }
              return ChangeNotifierProvider.value(
                value: DetailContactProvider(context),
                child: const DetailContactScreen(),
              );
            },
          ),
        ]),
  ],
);
