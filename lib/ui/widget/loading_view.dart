import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  final bool progress;
  final Widget child;

  const LoadingView({
    Key? key,
    required this.progress, required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          child,
          Visibility(child: Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ), visible: progress,)
        ]);
  }
}