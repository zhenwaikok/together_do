import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mpma_assignment/constant/color_manager.dart';

class CustomDatePickerField extends StatefulWidget {
  const CustomDatePickerField({
    super.key,
    required this.formName,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.initialValue,
  });

  final String formName;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final FormFieldValidator<DateTime>? validator;
  final DateTime? initialValue;

  @override
  State<CustomDatePickerField> createState() => _CustomDatePickerFieldState();
}

class _CustomDatePickerFieldState extends State<CustomDatePickerField> {
  @override
  Widget build(BuildContext context) {
    return getDatePickerField();
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CustomDatePickerFieldState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CustomDatePickerFieldState {
  Widget getDatePickerField() {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(
          primary: ColorManager.primary,
          onPrimary: Colors.white,
          onSurface: ColorManager.blackColor,
        ),
        dialogTheme: DialogThemeData(backgroundColor: Colors.white),
      ),
      child: FormBuilderDateTimePicker(
        name: widget.formName,
        validator: widget.validator,
        initialValue: widget.initialValue ?? DateTime.now(),
        inputType: InputType.date,
        decoration: InputDecoration(
          contentPadding: _Styles.contentPadding,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
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
      ),
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

  static final outlineErrorInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: ColorManager.redColor),
    borderRadius: BorderRadius.circular(10),
  );
}
