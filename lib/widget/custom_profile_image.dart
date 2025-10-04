import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:mpma_assignment/constant/images.dart';

class CustomProfileImage extends StatelessWidget {
  const CustomProfileImage({
    super.key,
    this.imageFile,
    this.imageURL,
    required this.imageSize,
  });

  final File? imageFile;
  final String? imageURL;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: imageSize,
      width: imageSize,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_Styles.borderRadius),
        child: imageFile != null
            ? Image.file(imageFile!, fit: BoxFit.cover)
            : (imageURL == null || (imageURL?.isEmpty ?? false))
            ? Image.asset(Images.profilePlaceHolderImage, fit: BoxFit.cover)
            : CachedNetworkImage(
                imageUrl: imageURL ?? '',
                placeholder: (context, url) => BlurHash(
                  hash: 'LNG[ySoeIURj9XWBX5WC0Kt6Rjxa',
                  imageFit: BoxFit.cover,
                  curve: Curves.bounceInOut,
                  duration: Duration(seconds: _Styles.blurDuration),
                ),
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
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
  static const borderRadius = 100.0;
}
