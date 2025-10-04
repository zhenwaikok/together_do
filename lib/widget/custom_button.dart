import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.textColor,
    this.backgroundColor,
    this.borderColor,
    required this.onPressed,
    this.icon,
    this.image,
    this.shadowColor,
  });

  final String text;
  final Color textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final void Function()? onPressed;
  final Icon? icon;
  final String? image;
  final WidgetStateProperty<Color?>? shadowColor;

  @override
  Widget build(BuildContext context) {
    return Skeleton.shade(
      child: SizedBox(
        width: double.infinity,
        height: _Styles.buttonHeight,
        child: ElevatedButton(
          onPressed: onPressed,
          style:
              ElevatedButton.styleFrom(
                backgroundColor: backgroundColor ?? ColorManager.primary,
                side: BorderSide(
                  color: borderColor ?? Colors.transparent,
                  width: _Styles.borderWidth,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(5.0),
                ),
              ).copyWith(
                overlayColor: WidgetStateProperty.all(
                  ColorManager.greyColor.withValues(alpha: 0.1),
                ),
                shadowColor: shadowColor,
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image != null
                  ? Image.asset(image ?? '', height: 15, width: 15)
                  : SizedBox.shrink(),
              image != null ? SizedBox(width: 5) : SizedBox(width: 0),

              icon ?? SizedBox.shrink(),
              icon != null ? SizedBox(width: 10) : SizedBox(width: 0),

              Text(
                text,
                style: _Styles.buttonTextStyle(color: textColor),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const double borderWidth = 1.5;
  static const double buttonHeight = 40.0;

  static TextStyle buttonTextStyle({required Color color}) {
    return TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: color);
  }
}
