import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/font_manager.dart';
import 'package:mpma_assignment/widget/custom_profile_image.dart';

class ChatRequestsTab extends StatefulWidget {
  const ChatRequestsTab({super.key});

  @override
  State<ChatRequestsTab> createState() => _ChatRequestsTabState();
}

class _ChatRequestsTabState extends State<ChatRequestsTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: _Styles.requestPadding, child: getFriendRequest());
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ChatRequestsTabState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ChatRequestsTabState {
  Widget getFriendRequest() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        getProfileImage(),
        SizedBox(width: 15),
        Expanded(child: getRequestName()),
        getActions(),
      ],
    );
  }

  Widget getProfileImage() {
    return CustomProfileImage(imageSize: _Styles.profileImageSize);
  }

  Widget getRequestName() {
    return Text('John Doe', style: _Styles.requestNameTextStyle);
  }

  Widget getActions() {
    return Row(
      children: [
        getIconButton(
          icon: Icons.close,
          onPressed: () {},
          backgroundColor: ColorManager.redColor,
        ),
        SizedBox(width: 15),
        getIconButton(
          icon: Icons.check,
          onPressed: () {},
          backgroundColor: ColorManager.greenColor,
        ),
      ],
    );
  }

  Widget getIconButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color backgroundColor,
  }) {
    return Container(
      width: _Styles.iconButtonSize,
      height: _Styles.iconButtonSize,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        color: ColorManager.whiteColor,
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const profileImageSize = 40.0;
  static const iconButtonSize = 40.0;

  static const EdgeInsets requestPadding = EdgeInsets.all(10.0);

  static const requestNameTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );
}
