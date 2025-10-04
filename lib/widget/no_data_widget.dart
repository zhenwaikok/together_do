import 'package:flutter/widgets.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/font_manager.dart';
import 'package:mpma_assignment/constant/images.dart';

class NoDataAvailableLabel extends StatelessWidget {
  const NoDataAvailableLabel({super.key, required this.noDataText});

  final String noDataText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          Images.noDataImage,
          width: _Styles.iconSize,
          height: _Styles.iconSize,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 10),
        Text(noDataText, style: _Styles.noLabelTextStyle),
      ],
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const double iconSize = 250.0;

  static const noLabelTextStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeightManager.semiBold,
    color: ColorManager.blackColor,
  );
}
