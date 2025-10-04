import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/font_manager.dart';

class CustomSortBy extends StatefulWidget {
  const CustomSortBy({
    super.key,
    required this.sortByItems,
    this.onChanged,
    required this.selectedValue,
    this.isExpanded = true,
    this.needBorder = true,
  });

  final List<String> sortByItems;
  final String? selectedValue;
  final void Function(String?)? onChanged;
  final bool? isExpanded;
  final bool? needBorder;

  @override
  State<CustomSortBy> createState() => _CustomSortByState();
}

class _CustomSortByState extends State<CustomSortBy> {
  @override
  Widget build(BuildContext context) {
    return getSortByButton();
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CustomSortByState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CustomSortByState {
  Widget getSortByButton() {
    return Container(
      decoration: BoxDecoration(
        border: widget.needBorder == true
            ? Border.all(color: ColorManager.lightGreyColor, width: 1)
            : null,
        borderRadius: BorderRadius.circular(_Styles.dropdownBorderRadius),
      ),
      child: DropdownButton<String>(
        isExpanded: widget.isExpanded ?? true,
        dropdownColor: ColorManager.whiteColor,
        underline: SizedBox(),
        value: widget.selectedValue,
        items: widget.sortByItems
            .map((value) => DropdownMenuItem(value: value, child: Text(value)))
            .toList(),
        onChanged: widget.onChanged,
        style: _Styles.dropdownTextStyle,
        padding: _Styles.dropdownPadding,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: ColorManager.blackColor,
        ),
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const dropdownBorderRadius = 5.0;
  static const dropdownPadding = EdgeInsetsGeometry.symmetric(horizontal: 10);

  static const dropdownTextStyle = TextStyle(
    fontSize: 15,
    color: ColorManager.blackColor,
    fontWeight: FontWeightManager.bold,
  );
}
