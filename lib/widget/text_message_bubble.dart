import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/font_manager.dart';
import 'package:mpma_assignment/widget/chat_card_wrapper.dart';

class TextMessageBubble extends StatelessWidget {
  const TextMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.createdTime,
  });

  final String message;
  final bool isMe;
  final DateTime createdTime;

  @override
  Widget build(BuildContext context) {
    return ChatCardWrapper(
      createdTime: createdTime,
      isMe: isMe,
      child: Text(
        message,
        style: _Styles.messageTextStyle,
        textAlign: TextAlign.justify,
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const messageTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );
}
