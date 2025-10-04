import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomBar extends StatelessWidget {
  const CustomBar({super.key, required this.child, this.backgroundColor});

  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Skeleton.shade(
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? ColorManager.primary,
            borderRadius: BorderRadius.circular(_Styles.borderRadius),
          ),
          child: Padding(padding: _Styles.childPadding, child: child),
        ),
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const borderRadius = 20.0;

  static const childPadding = EdgeInsets.symmetric(horizontal: 15, vertical: 3);
}
