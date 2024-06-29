import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trinity_wizard/provider/home/home_provider.dart';
import 'package:trinity_wizard/theme.dart';

import 'route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => HomeProvider(context),
        ),
      ],
      child: MaterialApp.router(
        title: 'Trinity Wizard',
        theme: DataTheme.themeData(),
        routerDelegate: route.routerDelegate,
        routeInformationParser: route.routeInformationParser,
        routeInformationProvider: route.routeInformationProvider,
      ),
    );
  }
}
