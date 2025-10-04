import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/color_manager.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({super.key, this.isActive = false, this.dotIndicatorSize});

  final bool isActive;
  final double? dotIndicatorSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: _Styles.animatedDuration),
      height: dotIndicatorSize ?? _Styles.dotIndicatorSize,
      width: dotIndicatorSize ?? _Styles.dotIndicatorSize,
      decoration: BoxDecoration(
        color: isActive ? ColorManager.primary : ColorManager.lightGreyColor,
        borderRadius: BorderRadius.all(Radius.circular(_Styles.borderRadius)),
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const dotIndicatorSize = 20.0;
  static const borderRadius = 12.0;
  static const animatedDuration = 300;
}
