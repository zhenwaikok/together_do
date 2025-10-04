import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/font_manager.dart';
import 'package:mpma_assignment/widget/adaptive_alert_dialog.dart';
import 'package:mpma_assignment/widget/custom_text_field.dart';

class WidgetUtil {
  static Future<T?> showAlertDialog<T>(
    BuildContext context, {
    required String? title,
    String? content,
    required List<Widget Function(BuildContext dialogContext)>? actions,
    String? formName,
    bool dismissible = true,
    bool needTextField = false,
    int? maxLines,
    String? Function(String?)? validator,
    GlobalKey<FormBuilderState>? formKey,
    String? hintText,
    Widget? customizeContent,
  }) {
    return showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.all(20),
        titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        actionsPadding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        title: Text(
          title ?? '',
          textAlign: TextAlign.justify,
          style: TextStyle(fontWeight: FontWeightManager.bold, fontSize: 20),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        content:
            customizeContent ??
            (needTextField
                ? FormBuilder(
                    key: formKey,
                    child: SizedBox(
                      width: double.maxFinite,
                      child: CustomTextField(
                        formName: formName ?? '',
                        validator: validator,
                        labelText: hintText,
                      ),
                    ),
                  )
                : Text(content ?? '', style: TextStyle(fontSize: 16))),
        actions: actions?.map((builder) => builder(dialogContext)).toList(),
        backgroundColor: ColorManager.whiteColor,
      ),
      barrierDismissible: dismissible,
    );
  }

  static Future<void> showDefaultErrorDialog(
    BuildContext context,
    String errorMessage,
  ) async {
    final List<Widget> actionBuilders = [
      TextButton(
        onPressed: () {
          context.router.maybePop();
        },
        child: Text('OK', style: TextStyle(color: ColorManager.blackColor)),
      ),
    ];
    if (context.mounted) {
      return showAdaptiveDialog<void>(
        context: context,
        builder: (context) => AdaptiveAlertDialog(
          errorMessage: errorMessage,
          actionBuilders: actionBuilders,
        ),
        useRootNavigator: false,
      );
    }
  }

  static Future<void> showSnackBar({required String text}) async {
    await Fluttertoast.cancel();
    const duration = 1;

    await Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: duration,
      backgroundColor: ColorManager.blackColor.withValues(alpha: 0.5),
      textColor: ColorManager.whiteColor,
      fontSize: 15.0,
    );
  }

  static Color getChoreStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return ColorManager.yellowColor;
      case 'completed':
        return ColorManager.greenColor;
      case 'ongoing':
        return ColorManager.primary;
      default:
        return ColorManager.primary;
    }
  }
}
