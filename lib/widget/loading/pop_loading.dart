import 'package:flutter/material.dart';

import 'loading_screen.dart';

popLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    useSafeArea: false,
    useRootNavigator: false,
    builder: (context) {
      return const LoadingScreen();
    },
  );
}
