import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/color_manager.dart';

class AdaptiveAlertDialog extends StatelessWidget {
  const AdaptiveAlertDialog({
    required this.errorMessage,
    required this.actionBuilders,
    super.key,
  });

  final String errorMessage;
  final List<Widget> actionBuilders;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      backgroundColor: ColorManager.whiteColor,
      title: Text(
        'Oops, something went wrong',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
      ),
      content: Text(errorMessage),
      actions: actionBuilders,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(_Styles.borderRadius),
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  static const borderRadius = 8.0;
}
