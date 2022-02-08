import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';
import 'dart:async';

class Refresh extends StatelessWidget {
  final Widget child;
  Refresh({required this.child});
  Widget build(context) {
    final bloc = StoriesProvider.of(context);
    return RefreshIndicator(
        child: child,
        onRefresh: () async {
          await bloc.clearCache();
        });
  }
}
