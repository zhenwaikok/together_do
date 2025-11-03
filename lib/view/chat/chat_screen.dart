import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mpma_assignment/base_stateful_page.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/router/router.gr.dart';
import 'package:mpma_assignment/view/chat/chat_friends_tab.dart';
import 'package:mpma_assignment/view/chat/chat_requests_tab.dart';
import 'package:mpma_assignment/widget/custom_app_bar.dart';
import 'package:mpma_assignment/widget/custom_tab_bar.dart';
import 'package:mpma_assignment/widget/search_bar.dart';
import 'package:mpma_assignment/widget/touchable_capacity.dart';

@RoutePage()
class ChatScreen extends BaseStatefulPage {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseStatefulState<ChatScreen> {
  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(isBackButtonVisible: false, title: 'Chat');
  }

  @override
  Widget body() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          getTabBar(),
          SizedBox(height: 20),
          Expanded(
            child: TabBarView(
              children: [
                buildTabContent(showFriends: true),
                buildTabContent(showFriends: false),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ChatScreenState {
  void onFriendPressed() {
    context.router.push(ChatRoomRoute());
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ChatScreenState {
  Widget getTabBar() {
    return CustomTabBar(tabs: [Text('Friends'), Text('Requests')]);
  }

  Widget getSearchBar() {
    return CustomSearchBar(hintText: 'Search');
  }

  Widget buildTabContent({required bool showFriends}) {
    return AdaptiveWidgets.buildRefreshableScrollView(
      context,
      onRefresh: () async {},
      color: ColorManager.blackColor,
      refreshIndicatorBackgroundColor: ColorManager.whiteColor,
      slivers: [
        if (showFriends)
          SliverToBoxAdapter(
            child: Padding(
              padding: _Styles.searchBarPadding,
              child: getSearchBar(),
            ),
          ),

        ...(showFriends ? getFriendsList() : getFriendRequestsList()),
      ],
    );
  }

  List<Widget> getFriendsList() {
    return [
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return TouchableOpacity(
            onPressed: onFriendPressed,
            child: ChatFriendsTab(),
          );
        }, childCount: 5),
      ),
    ];
  }

  List<Widget> getFriendRequestsList() {
    return [
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return ChatRequestsTab();
        }, childCount: 5),
      ),
    ];
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const searchBarPadding = EdgeInsets.all(8.0);
}
