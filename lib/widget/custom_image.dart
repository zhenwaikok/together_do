import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/images.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.imageURL,
    this.imageSize,
    this.borderRadius,
    this.imageWidth,
    this.darken = false,
  });

  final String imageURL;
  final double? imageSize;
  final double? borderRadius;
  final double? imageWidth;
  final bool? darken;

  @override
  Widget build(BuildContext context) {
    if (imageURL.isEmpty) {
      return Container(
        height: imageSize,
        width: imageWidth ?? imageSize,
        decoration: BoxDecoration(
          color: ColorManager.lightGreyColor2,
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
        ),
        child: Image.asset(Images.greyAppLogo, fit: BoxFit.cover),
      );
    }

    return SizedBox(
      height: imageSize,
      width: imageWidth ?? imageSize,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        child: CachedNetworkImage(
          imageUrl: imageURL,
          placeholder: (context, url) => BlurHash(
            hash: 'LNG[ySoeIURj9XWBX5WC0Kt6Rjxa',
            imageFit: BoxFit.cover,
            curve: Curves.bounceInOut,
            duration: Duration(seconds: _Styles.blurDuration),
          ),
          imageBuilder: (context, imageProvider) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (darken ?? false)
                  Container(color: Colors.black.withValues(alpha: 0.3)),
              ],
            );
          },
        ),
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const blurDuration = 5;
}
