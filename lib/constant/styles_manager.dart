import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/font_manager.dart';

class StylesManager {
  static const zeroPadding = EdgeInsets.zero;
  static const screenPadding = EdgeInsets.all(20);
  static final emptyWidget = const SizedBox.shrink();
  static const maxTextLines1 = 1;
  static const maxTextLines2 = 2;
  static const maxTextLines3 = 3;

  static final textButtonStyle = ButtonStyle(
    overlayColor: WidgetStateProperty.all(ColorManager.lightGreyColor2),
  );

  static const textButtonTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );
}
