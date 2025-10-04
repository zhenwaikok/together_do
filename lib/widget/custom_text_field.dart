import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/font_manager.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.fontSize,
    this.color,
    this.title,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.keyboardType,
    this.validator,
    this.inputFormatters,
    this.controller,
    this.readonly,
    required this.formName,
    this.needTitle = true,
    this.maxLines,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.isPassword = false,
    this.initialValue,
    this.labelText,
  });

  final String formName;
  final double? fontSize;
  final Color? color;
  final String? title;
  final Icon? prefixIcon;
  final IconButton? suffixIcon;
  final void Function()? onTap;
  final void Function(String? value)? onChanged;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final bool? readonly;
  final bool? needTitle;
  final int? maxLines;
  final AutovalidateMode autovalidateMode;
  final bool? isPassword;
  final String? initialValue;
  final String? labelText;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.needTitle ?? true)
          getTitle(
            title: widget.title ?? '',
            fontSize: widget.fontSize ?? 0,
            color: widget.color ?? Colors.transparent,
          ),
        SizedBox(height: 10),
        getTextField(name: widget.formName),
      ],
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CustomTextFieldState {
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

  Widget getTextField({required String name}) {
    return FormBuilderTextField(
      name: name,
      obscureText: widget.isPassword ?? false,
      maxLines: (widget.isPassword ?? false) ? 1 : widget.maxLines,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      autovalidateMode: widget.autovalidateMode,
      initialValue: widget.initialValue,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      controller: widget.controller,
      readOnly: widget.readonly ?? false,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: _Styles.labelTextStyle,
        contentPadding: _Styles.contentPadding,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        border: _Styles.outlineInputBorder(),
        focusedBorder: _Styles.outlineInputBorder(),
        enabledBorder: _Styles.outlineInputBorder(),
        errorBorder: _Styles.outlineErrorInputBorder(),
        focusedErrorBorder: _Styles.outlineErrorInputBorder(),
      ),
      cursorColor: ColorManager.blackColor,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const contentPadding = EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 10,
  );

  static OutlineInputBorder outlineInputBorder({Color? color, double? width}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color ?? ColorManager.greyColor.withValues(alpha: 0.3),
        width: width ?? 2,
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }

  static OutlineInputBorder outlineErrorInputBorder({Color? color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color ?? ColorManager.redColor),
      borderRadius: BorderRadius.circular(10),
    );
  }

  static TextStyle titleTextStyle({
    required double fontSize,
    FontWeight fontWeight = FontWeightManager.bold,
    required Color color,
  }) {
    return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
  }

  static const labelTextStyle = TextStyle(
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );
}
