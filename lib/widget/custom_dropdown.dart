import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/font_manager.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    super.key,
    required this.formName,
    this.items,
    this.title,
    this.fontSize,
    this.color,
    this.onChanged,
    this.needTitle = true,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.initialValue,
    this.unmapItems,
  });

  final String? title;
  final double? fontSize;
  final Color? color;
  final String formName;
  final List<String>? items;
  final List<DropdownMenuItem<String>>? unmapItems;
  final String? initialValue;
  final void Function(String?)? onChanged;
  final bool? needTitle;
  final String? Function(String? value)? validator;
  final AutovalidateMode autovalidateMode;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.needTitle == true)
          getTitle(
            title: widget.title ?? '',
            fontSize: widget.fontSize ?? 0,
            color: widget.color ?? Colors.transparent,
          ),
        SizedBox(height: 10),
        getDropdownField(),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CustomDropdownState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CustomDropdownState {
  Widget getTitle({
    required String title,
    required double fontSize,
    required Color color,
  }) {
    return Text(
      title,
      style: _Styles.titleTextStyle(fontSize: fontSize, color: color),
    );
  }

  Widget getDropdownField() {
    return FormBuilderDropdown<String>(
      name: widget.formName,
      initialValue:
          widget.initialValue ??
          (widget.items?.isNotEmpty == true ? widget.items![0] : null),
      items:
          widget.unmapItems ??
          (widget.items != null
              ? widget.items!
                    .map(
                      (item) =>
                          DropdownMenuItem(value: item, child: Text(item)),
                    )
                    .toList()
              : []),
      dropdownColor: ColorManager.whiteColor,
      validator: widget.validator,
      decoration: InputDecoration(
        contentPadding: _Styles.contentPadding,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.greyColor.withValues(alpha: 0.3),
            width: _Styles.textFieldBorderWidth,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.greyColor.withValues(alpha: 0.3),
            width: _Styles.textFieldBorderWidth,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: _Styles.outlineErrorInputBorder,
        focusedErrorBorder: _Styles.outlineErrorInputBorder,
      ),
      onChanged: widget.onChanged,
      autovalidateMode: widget.autovalidateMode,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const textFieldBorderWidth = 2.0;
  static const contentPadding = EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 10,
  );

  static TextStyle titleTextStyle({
    required double fontSize,
    FontWeight fontWeight = FontWeightManager.bold,
    required Color color,
  }) {
    return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
  }

  static final outlineErrorInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: ColorManager.redColor),
    borderRadius: BorderRadius.circular(10),
  );
}
