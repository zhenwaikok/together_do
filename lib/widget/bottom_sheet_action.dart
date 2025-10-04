import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/font_manager.dart';

class BottomSheetAction extends StatelessWidget {
  const BottomSheetAction({
    super.key,
    required this.icon,
    required this.color,
    required this.text,
    this.onTap,
  });

  final IconData icon;
  final Color color;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return getBottomSheetAction();
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on BottomSheetAction {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on BottomSheetAction {
  Widget getBottomSheetAction() {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(_Styles.inkWellBorderRadus),
      child: Padding(
        padding: _Styles.inkWellPadding,
        child: Row(
          children: [
            Icon(icon, color: color, size: _Styles.bottomSheetActionIconSize),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: _Styles.bottomSheetActionTextStyle(color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const bottomSheetActionIconSize = 25.0;
  static const inkWellBorderRadus = 10.0;

  static const inkWellPadding = EdgeInsets.all(5);

  static TextStyle bottomSheetActionTextStyle({required Color color}) =>
      TextStyle(
        fontSize: 16,
        fontWeight: FontWeightManager.regular,
        color: color,
      );
}
