import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/color_manager.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
    this.onPressed,
    required this.icon,
    this.heroTag,
  });

  final Widget icon;
  final void Function()? onPressed;
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: CircleBorder(),
      onPressed: onPressed,
      backgroundColor: ColorManager.primary,
      heroTag: heroTag,
      child: icon,
    );
  }
}
