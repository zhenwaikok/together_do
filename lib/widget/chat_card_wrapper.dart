import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/font_manager.dart';
import 'package:mpma_assignment/utils/extensions/string_extension.dart';
import 'package:mpma_assignment/widget/custom_profile_image.dart';

class ChatCardWrapper extends StatelessWidget {
  const ChatCardWrapper({
    super.key,
    required this.child,
    required this.createdTime,
    required this.isMe,
  });

  final Widget child;
  final DateTime createdTime;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _Styles.messageRowPadding,
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            getProfileImage(),
            SizedBox(width: 8),
            getMessageCard(
              child: child,
              time: createdTime,
              isMe: isMe,
              context: context,
            ),
          ] else ...[
            getMessageCard(
              child: child,
              time: createdTime,
              isMe: isMe,
              context: context,
            ),
            SizedBox(width: 8),
            getProfileImage(),
          ],
        ],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on ChatCardWrapper {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on ChatCardWrapper {
  Widget getMessageCard({
    required BuildContext context,
    required Widget child,
    required DateTime time,
    required bool isMe,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.6,
      ),
      child: Container(
        padding: _Styles.messageCardPadding,
        decoration: BoxDecoration(
          color: isMe ? ColorManager.primary3 : ColorManager.lightGreyColor2,
          borderRadius: _Styles.messageCardBorderRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            child,
            SizedBox(height: 8),
            getCreatedTime(time: time),
          ],
        ),
      ),
    );
  }

  Widget getCreatedTime({required DateTime time}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        StringExtension.timeFormatter(time),
        style: _Styles.createdTimeTextStyle,
      ),
    );
  }

  Widget getProfileImage() {
    return CustomProfileImage(imageSize: _Styles.imageSize);
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const imageSize = 35.0;

  static const messageCardPadding = EdgeInsets.all(15);
  static const messageRowPadding = EdgeInsets.symmetric(vertical: 8);

  static final messageCardBorderRadius = BorderRadius.circular(10);

  static const createdTimeTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );
}
