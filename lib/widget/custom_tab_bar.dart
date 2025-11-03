import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/color_manager.dart';

import 'package:mpma_assignment/constant/font_manager.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return getTabBar();
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CustomTabBarState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CustomTabBarState {
  Widget getTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.lightGreyColor2,
        borderRadius: BorderRadius.circular(_Styles.tabBarBorderRadius),
      ),
      child: TabBar(
        tabs: widget.tabs,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadius.circular(_Styles.tabBarBorderRadius),
        ),
        indicatorColor: ColorManager.primary,
        labelColor: ColorManager.whiteColor,
        unselectedLabelColor: ColorManager.blackColor.withValues(alpha: 0.5),
        labelStyle: _Styles.tabLabelTextStyle,
        labelPadding: _Styles.tabBarLabelPadding,
        dividerColor: Colors.transparent,
        overlayColor: _Styles.overlayColor,
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const tabBarBorderRadius = 30.0;

  static const tabBarLabelPadding = EdgeInsets.symmetric(vertical: 8);

  static const tabLabelTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
  );

  static final overlayColor = WidgetStateProperty.all<Color>(
    Colors.transparent,
  );
}
