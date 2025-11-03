import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/widget/custom_profile_image.dart';

class ChatFriendsTab extends StatefulWidget {
  const ChatFriendsTab({super.key});

  @override
  State<ChatFriendsTab> createState() => _ChatFriendsTabState();
}

class _ChatFriendsTabState extends State<ChatFriendsTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: _Styles.friendPadding, child: getFriendRow());
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ChatFriendsTabState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ChatFriendsTabState {
  Widget getFriendRow() {
    return Row(
      children: [
        getProfileImage(),
        SizedBox(width: 15),
        Expanded(child: getFriendItem()),
      ],
    );
  }

  Widget getProfileImage() {
    return CustomProfileImage(imageSize: _Styles.profileImageSize);
  }

  Widget getFriendItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [getNameAndTime(), getMessageAndUnreadCount()],
    );
  }

  Widget getNameAndTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('John Doe', style: _Styles.nameTextStyle),
        Text('1m', style: _Styles.timeTextStyle),
      ],
    );
  }

  Widget getMessageAndUnreadCount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Hey! How are you?', style: _Styles.messageTextStyle),
        Container(
          padding: _Styles.unreadCountPadding,
          decoration: BoxDecoration(
            color: ColorManager.primary,
            shape: BoxShape.circle,
          ),
          child: Text('2', style: _Styles.unreadCountTextStyle),
        ),
      ],
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const profileImageSize = 40.0;

  static const EdgeInsets unreadCountPadding = EdgeInsets.all(5);
  static const EdgeInsets friendPadding = EdgeInsets.symmetric(
    vertical: 15,
    horizontal: 10,
  );
  static const nameTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: ColorManager.blackColor,
  );

  static const timeTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: ColorManager.primary,
  );

  static const messageTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.bold,
    color: ColorManager.blackColor,
  );

  static const unreadCountTextStyle = TextStyle(
    color: ColorManager.whiteColor,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );
}
