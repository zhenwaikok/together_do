import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:mpma_assignment/widget/chat_card_wrapper.dart';
import 'package:mpma_assignment/widget/custom_image.dart';

class ImageMessageBubble extends StatelessWidget {
  const ImageMessageBubble({
    super.key,
    required this.imageURL,
    required this.isMe,
    required this.createdTime,
  });

  final String imageURL;
  final bool isMe;
  final DateTime createdTime;

  @override
  Widget build(BuildContext context) {
    return ChatCardWrapper(
      createdTime: createdTime,
      isMe: isMe,
      child: getImage(imageURL: imageURL),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on ImageMessageBubble {
  Widget getImage({required String imageURL}) {
    return FullScreenWidget(
      disposeLevel: DisposeLevel.High,
      child: Center(
        child: CustomImage(
          imageURL: imageURL,
          imageSize: _Styles.imageSize,
          imageWidth: double.infinity,
        ),
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const imageSize = 200.0;
}
