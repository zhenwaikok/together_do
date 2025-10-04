import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/font_manager.dart';
import 'package:mpma_assignment/constant/styles_manager.dart';
import 'package:mpma_assignment/model/space_model/space_model.dart';
import 'package:mpma_assignment/widget/custom_card.dart';
import 'package:mpma_assignment/widget/custom_image.dart';
import 'package:mpma_assignment/widget/touchable_capacity.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SpaceCard extends StatelessWidget {
  const SpaceCard({
    super.key,
    required this.space,
    required this.isLoading,
    required this.onPressed,
  });

  final SpaceModel space;
  final bool isLoading;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return getSpacesCard(space: space);
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on SpaceCard {
  Widget getSpacesCard({required SpaceModel space}) {
    return Skeletonizer(
      enabled: isLoading,
      child: TouchableOpacity(
        isLoading: isLoading,
        onPressed: onPressed,
        child: CustomCard(
          padding: StylesManager.zeroPadding,
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomImage(
                  borderRadius: _Styles.imageBorderRadius,
                  darken: true,
                  imageSize: double.infinity,
                  imageWidth: double.infinity,
                  imageURL: space.imageURL ?? '',
                ),
              ),

              Positioned.fill(
                child: Center(
                  child: Text(
                    space.name ?? '',
                    style: _Styles.spaceNameTextStyle,
                    maxLines: StylesManager.maxTextLines2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const imageBorderRadius = 15.0;

  static const spaceNameTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.whiteColor,
  );
}
