import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/font_manager.dart';
import 'package:mpma_assignment/constant/styles_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    required this.isBackButtonVisible,
    this.onPressed,
    this.actions,
    this.child,
  });

  final String? title;
  final VoidCallback? onPressed;
  final List<Widget>? actions;
  final bool isBackButtonVisible;
  final Widget? child;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorManager.whiteColor,
      surfaceTintColor: Colors.transparent,
      title:
          child ??
          Text(
            title ?? '',
            style: _Styles.titleTextStyle,
            maxLines: StylesManager.maxTextLines1,
            overflow: TextOverflow.ellipsis,
          ),
      leading: isBackButtonVisible
          ? getBackButton(onPressed: onPressed ?? () {})
          : null,
      actions: actions,
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on CustomAppBar {
  Widget getBackButton({required VoidCallback onPressed}) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        Icons.arrow_back_ios_new_rounded,
        color: ColorManager.blackColor,
      ),
      iconSize: _Styles.backButtonSize,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const backButtonSize = 25.0;

  static const titleTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );
}
