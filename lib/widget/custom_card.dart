import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/styles_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    this.padding,
    this.needBoxShadow = true,
    this.backgroundColor,
    this.borderRadius,
    this.child,
    this.needBorder = false,
  });

  final EdgeInsetsGeometry? padding;
  final bool? needBoxShadow;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final Widget? child;
  final bool? needBorder;

  @override
  Widget build(BuildContext context) {
    return Skeleton.shade(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: (needBorder ?? false)
              ? Border.all(color: ColorManager.greyColor)
              : null,
          color: backgroundColor ?? ColorManager.whiteColor,
          borderRadius:
              borderRadius ?? BorderRadius.circular(_Styles.cardBorderRadius),
          boxShadow: (needBoxShadow ?? true)
              ? [
                  BoxShadow(
                    color: ColorManager.blackColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    spreadRadius: 0.2,
                    offset: Offset(0, 5),
                  ),
                ]
              : null,
        ),
        child: Padding(
          padding: padding ?? StylesManager.screenPadding,
          child: child,
        ),
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const cardBorderRadius = 15.0;
}
