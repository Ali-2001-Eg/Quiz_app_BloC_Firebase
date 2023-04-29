import 'package:firebase_app/config/themes/app_colors.dart';
import 'package:firebase_app/config/themes/ui_parameters.dart';
import 'package:flutter/material.dart';

class ContentAreaWidget extends StatelessWidget {
  const ContentAreaWidget({
    Key? key,
    this.addPadding = true,
    required this.child,
  }) : super(key: key);
  final bool addPadding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20),bottom: Radius.circular(20)),
      clipBehavior: Clip.hardEdge,
      type: MaterialType.transparency,
      child: Ink(
        width: double.infinity,
        decoration: BoxDecoration(
          color: customScaffoldColor(context),
        ),
        padding: addPadding
            ? EdgeInsets.only(
                top: mobileScreenPadding, left: mobileScreenPadding, right: mobileScreenPadding)
            : EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
