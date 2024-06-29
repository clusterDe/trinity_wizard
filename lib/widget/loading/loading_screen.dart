import 'package:flutter/material.dart';

import '../../constant.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.black45,
        body: Center(
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(defBorderRadius),
            ),
            child: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        ),
      ),
    );
  }
}
