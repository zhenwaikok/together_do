import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/color_manager.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    this.onChanged,
    this.controller,
    required this.hintText,
    this.onPressed,
  });

  final void Function(String? value)? onChanged;
  final TextEditingController? controller;
  final void Function()? onPressed;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return getTextField();
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on CustomSearchBar {
  Widget getTextField() {
    return Container(
      width: double.infinity,
      height: _Styles.searchBarHeight,
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(_Styles.searchBarBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            spreadRadius: 0.5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: _Styles.contentPadding,
          prefixIcon: Icon(
            Icons.search,
            color: ColorManager.blackColor,
            size: _Styles.searchIconSize,
          ),
          suffixIcon: controller?.text.isNotEmpty ?? false
              ? IconButton(
                  onPressed: onPressed,
                  icon: Icon(Icons.clear, color: ColorManager.blackColor),
                )
              : null,
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        cursorColor: ColorManager.blackColor,
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const searchIconSize = 25.0;
  static const searchBarHeight = 50.0;
  static const searchBarBorderRadius = 20.0;

  static const contentPadding = EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 10,
  );
}
