import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/font_manager.dart';
import 'package:mpma_assignment/constant/styles_manager.dart';
import 'package:mpma_assignment/widget/chat_card_wrapper.dart';
import 'package:mpma_assignment/widget/touchable_capacity.dart';

class DocumentMessageBubble extends StatelessWidget {
  const DocumentMessageBubble({
    super.key,
    required this.isMe,
    required this.createdTime,
    required this.documentName,
    required this.onTap,
  });

  final bool isMe;
  final DateTime createdTime;
  final String documentName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChatCardWrapper(
      createdTime: createdTime,
      isMe: isMe,
      child: getDocumentView(documentName: documentName),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on DocumentMessageBubble {
  Widget getDocumentView({required String documentName}) {
    return TouchableOpacity(
      onPressed: onTap,
      child: ClipRRect(
        borderRadius: _Styles.selectedMediaBorderRadius,
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.antiAlias,
          children: [
            Container(
              decoration: BoxDecoration(color: ColorManager.lightGreyColor2),
              width: double.infinity,
              height: _Styles.selectedMediaSize,
              child: Icon(
                Icons.description,
                size: 60,
                color: ColorManager.blackColor,
              ),
            ),
            getDocumentNameContainer(documentName: documentName),
          ],
        ),
      ),
    );
  }

  Widget getDocumentNameContainer({required String documentName}) {
    return Container(
      padding: _Styles.documentNameContainerPadding,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        boxShadow: [
          BoxShadow(
            color: ColorManager.blackColor.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Text(
        documentName,
        style: _Styles.documentNameTextStyle,
        textAlign: TextAlign.center,
        maxLines: StylesManager.maxTextLines1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const selectedMediaSize = 140.0;

  static const BorderRadius selectedMediaBorderRadius = BorderRadius.all(
    Radius.circular(8.0),
  );

  static const documentNameContainerPadding = EdgeInsets.all(5.0);

  static const documentNameTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );
}
