import 'package:flutter/material.dart';

class AppButtonFeedBack extends StatelessWidget {
  const AppButtonFeedBack(
      {Key? key, required this.child, required this.onTap})
      : super(key: key);

  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }
}
