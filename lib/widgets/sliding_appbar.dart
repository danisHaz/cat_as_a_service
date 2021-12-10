import 'package:flutter/material.dart';

// https://stackoverflow.com/questions/53941362/flutter-how-can-i-dynamically-show-or-hide-app-bars-on-pages
class SlidingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SlidingAppBar({
    Key? key,
    required this.child,
    required this.controller,
    required this.visible,
  }) : super(key: key);

  final PreferredSizeWidget child;
  final AnimationController controller;
  final bool visible;

  @override
  Size get preferredSize => child.preferredSize;

  @override
  Widget build(BuildContext context) {
    visible ? controller.reverse() : controller.forward();
    return SlideTransition(
      position:
          Tween<Offset>(begin: Offset.zero, end: const Offset(0, -1)).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
      ),
      child: child,
    );
  }
}
