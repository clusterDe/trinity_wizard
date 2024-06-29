// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsumerStateData<T> extends StatelessWidget {
  const ConsumerStateData({
    super.key,
    required this.state,
    required this.enumValue,
    required this.message,
    this.isSliver = false,
    required this.builder,
  });

  final Enum state;
  final List<Enum> enumValue;
  final String message;

  final bool? isSliver;

  final Widget Function(
    BuildContext context,
    T value,
    Widget? child,
  ) builder;

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, provider, child) {
        if (state == enumValue[0]) {
          if (isSliver!) {
            return const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        } else if (state == enumValue[2]) {
          return builder(
            context,
            Provider.of<T>(context),
            child,
          );
        } else if (state == enumValue[1]) {
          if (isSliver!) {
            return SliverToBoxAdapter(
              child: Center(
                child: Text(message),
              ),
            );
          } else {
            return Center(
              child: Text(message),
            );
          }
        } else if (state == enumValue[3]) {
          if (isSliver!) {
            return SliverToBoxAdapter(
              child: Center(
                child: Text(message),
              ),
            );
          } else {
            return Center(
              child: Text(message),
            );
          }
        } else {
          return builder(
            context,
            Provider.of<T>(context),
            child,
          );
        }
      },
    );
  }
}
