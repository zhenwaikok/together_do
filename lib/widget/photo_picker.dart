import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/font_manager.dart';
import 'package:mpma_assignment/widget/touchable_capacity.dart';

class PhotoPicker extends StatefulWidget {
  const PhotoPicker({
    super.key,
    required this.onTap,
    required this.selectedImage,
    this.borderRadius,
  });

  final void Function()? onTap;
  final File selectedImage;
  final double? borderRadius;

  @override
  State<PhotoPicker> createState() => _PhotoPickerState();
}

class _PhotoPickerState extends State<PhotoPicker> {
  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onPressed: widget.onTap,
      child: Container(
        width: double.infinity,
        height: widget.selectedImage.path.isNotEmpty
            ? null
            : _Styles.containerHeight,
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          border: Border.all(
            color: widget.selectedImage.path.isNotEmpty
                ? Colors.transparent
                : ColorManager.blackColor,
            width: _Styles.borderWidth,
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 0.0),
        ),
        child: widget.selectedImage.path.isNotEmpty
            ? Image.file(
                height: _Styles.containerHeight,
                width: double.infinity,
                widget.selectedImage,
                fit: BoxFit.contain,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image,
                    size: _Styles.iconSize,
                    color: ColorManager.blackColor,
                  ),
                  SizedBox(height: 10),
                  Text('Select Image', style: _Styles.textStyle),
                ],
              ),
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const iconSize = 50.0;
  static const borderWidth = 2.0;
  static const containerHeight = 200.0;

  static const textStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );
}
