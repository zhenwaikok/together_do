import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mpma_assignment/base_stateful_page.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/font_manager.dart';
import 'package:mpma_assignment/constant/styles_manager.dart';
import 'package:mpma_assignment/repository/space_repository.dart';
import 'package:mpma_assignment/repository/user_repository.dart';
import 'package:mpma_assignment/services/space_services.dart';
import 'package:mpma_assignment/services/user_services.dart';
import 'package:mpma_assignment/utils/shared_preference_handler.dart';
import 'package:mpma_assignment/utils/util.dart';
import 'package:mpma_assignment/viewmodel/chore_view_model.dart';
import 'package:mpma_assignment/viewmodel/space_member_details_view_model.dart';
import 'package:mpma_assignment/viewmodel/space_view_model.dart';
import 'package:mpma_assignment/viewmodel/user_view_model.dart';
import 'package:mpma_assignment/widget/bottom_sheet_action.dart';
import 'package:mpma_assignment/widget/custom_app_bar.dart';
import 'package:mpma_assignment/widget/custom_profile_image.dart';
import 'package:mpma_assignment/widget/no_data_widget.dart';
import 'package:mpma_assignment/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key, required this.spaceID});

  final String spaceID;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        SpaceViewModel(
          spaceRepository: SpaceRepository(spaceServices: SpaceServices()),
        );
        SpaceMemberDetailsViewModel(
          userRepository: UserRepository(
            sharedPreferenceHandler: SharedPreferenceHandler(),
            userServices: UserServices(),
          ),
        );
      },
      child: _MembersScreen(spaceID: spaceID),
    );
  }
}

class _MembersScreen extends BaseStatefulPage {
  const _MembersScreen({required this.spaceID});

  final String spaceID;
  @override
  State<_MembersScreen> createState() => __MembersScreenState();
}

class __MembersScreenState extends BaseStatefulState<_MembersScreen> {
  List<Map<String, String>> allMembersList = [];
  bool _isLoading = true;
  bool refreshData = false;

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Members',
      isBackButtonVisible: true,
      onPressed: onBackButtonPressed,
    );
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return StylesManager.zeroPadding;
  }

  @override
  Widget body() {
    final creatorUserID = context.select(
      (SpaceViewModel vm) => vm.spaceDetails?.creatorUserID ?? '',
    );
    final currentUserID = context.select(
      (UserViewModel vm) => vm.user?.userID ?? '',
    );
    final isSpaceAdmin = creatorUserID == currentUserID;

    final loadingList = List.generate(5, (index) => <String, String>{});

    return AdaptiveWidgets.buildRefreshableScrollView(
      context,
      onRefresh: fetchData,
      color: ColorManager.blackColor,
      refreshIndicatorBackgroundColor: ColorManager.whiteColor,
      slivers: [
        ...getMemberList(
          creatorUserID: creatorUserID,
          isSpaceAdmin: isSpaceAdmin,
          memberList: _isLoading ? loadingList : allMembersList,
        ),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on __MembersScreenState {
  void onBackButtonPressed() {
    context.router.maybePop(refreshData);
  }

  Future<void> fetchData() async {
    _setState(() {
      _isLoading = true;
      allMembersList.clear();
    });

    await tryCatch(
      context,
      () => context.read<SpaceViewModel>().getSpaceDetails(
        spaceID: widget.spaceID,
      ),
    );

    if (mounted) {
      final memberList =
          context.read<SpaceViewModel>().spaceDetails?.memberUserIDs ?? [];

      for (final memberUserID in memberList) {
        if (mounted) {
          await tryCatch(
            context,
            () => context.read<SpaceMemberDetailsViewModel>().getMemberDetails(
              userID: memberUserID,
              updateSharedPreference: false,
            ),
          );
        }

        await populateMemberMap(memberUserID: memberUserID);
      }
    }

    _setState(() {
      _isLoading = false;
    });
  }

  Future<void> populateMemberMap({required String memberUserID}) async {
    final creatorUserID = context
        .read<SpaceViewModel>()
        .spaceDetails
        ?.creatorUserID;

    final currentUserID = context.read<UserViewModel>().user?.userID ?? '';

    final userDetails = context.read<SpaceMemberDetailsViewModel>().userDetails;

    if (userDetails != null) {
      allMembersList.add({
        'userID': userDetails.userID ?? '',
        'profileImageURL': userDetails.profileImageURL ?? '',
        'name': memberUserID == currentUserID
            ? '${userDetails.firstName ?? ''} ${userDetails.lastName ?? ''} (You)'
            : '${userDetails.firstName ?? ''} ${userDetails.lastName ?? ''}',
        'role': memberUserID == creatorUserID ? 'Admin' : 'Member',
      });
    }
  }

  void onMemberLongPressed({required String userID}) {
    showModalBottomSheet(
      backgroundColor: ColorManager.whiteColor,
      context: context,
      builder: (context) {
        return getBottomSheet(userID: userID);
      },
    );
  }

  void onRemovePressed({required String userID}) async {
    await context.router.maybePop();
    if (mounted) {
      WidgetUtil.showAlertDialog(
        context,
        title: 'Delete Confirmation',
        content: 'Are you sure you want to remove this member from the space?',
        actions: [
          (dialogContext) => getAlertDialogTextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            text: 'No',
          ),
          (dialogContext) => getAlertDialogTextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              onYesRemovePressed(userID: userID);
            },
            text: 'Yes',
          ),
        ],
      );
    }
  }

  Future<void> onYesRemovePressed({required String userID}) async {
    final deleteSpaceChoresResult =
        await tryLoad(
          context,
          () => context.read<ChoreViewModel>().deleteChore(
            spaceID: widget.spaceID,
            userID: userID,
          ),
        ) ??
        false;

    if (deleteSpaceChoresResult && mounted) {
      final leaveSpaceResult =
          await tryLoad(
            context,
            () => context.read<SpaceViewModel>().removeMemberOrLeaveSpace(
              spaceID: widget.spaceID,
              userID: userID,
            ),
          ) ??
          false;

      if (leaveSpaceResult) {
        _setState(() {
          refreshData = true;
        });
        await fetchData();
      }
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on __MembersScreenState {
  List<Widget> getMemberList({
    required String creatorUserID,
    required bool isSpaceAdmin,
    required List<Map<String, String>> memberList,
  }) {
    if (!_isLoading && memberList.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: NoDataAvailableLabel(noDataText: 'No members available.'),
          ),
        ),
      ];
    }

    return [
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final member = memberList[index];

          return getMemberCard(
            creatorUserID: creatorUserID,
            isSpaceAdmin: isSpaceAdmin,
            userID: member['userID'] ?? '',
            profileImageURL: member['profileImageURL'] ?? '',
            memberName: member['name'] ?? 'Loading...',
            memberRole: member['role'] ?? 'Loading...',
          );
        }, childCount: memberList.length),
      ),
    ];
  }

  Widget getMemberCard({
    required String userID,
    required bool isSpaceAdmin,
    required String profileImageURL,
    required String memberName,
    required String memberRole,
    required String creatorUserID,
  }) {
    return Column(
      children: [
        Skeletonizer(
          enabled: _isLoading,
          child: TouchableOpacity(
            onLongPress: isSpaceAdmin
                ? creatorUserID == userID
                      ? null
                      : () => onMemberLongPressed(userID: userID)
                : null,
            child: Row(
              children: [
                getMemberProfileImage(imageURL: profileImageURL),
                SizedBox(width: 20),
                Expanded(
                  child: getMemberDetails(
                    memberName: memberName,
                    memberRole: memberRole,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: _Styles.memberCardPadding,
          child: Divider(color: ColorManager.greyColor),
        ),
      ],
    );
  }

  Widget getMemberProfileImage({required String imageURL}) {
    return CustomProfileImage(imageSize: _Styles.imageSize, imageURL: imageURL);
  }

  Widget getMemberDetails({
    required String memberName,
    required String memberRole,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          memberName,
          style: _Styles.memberNameTextStyle,
          maxLines: StylesManager.maxTextLines1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 5),
        Text(
          memberRole,
          style: _Styles.memberRoleTextStyle,
          maxLines: StylesManager.maxTextLines1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget getBottomSheet({required String userID}) {
    return Padding(
      padding: StylesManager.screenPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetAction(
            icon: Icons.delete_outline,
            color: ColorManager.redColor,
            text: 'Remove',
            onTap: () => onRemovePressed(userID: userID),
          ),
        ],
      ),
    );
  }

  Widget getAlertDialogTextButton({
    required void Function()? onPressed,
    required String text,
  }) {
    return TextButton(
      style: StylesManager.textButtonStyle,
      onPressed: onPressed,
      child: Text(text, style: StylesManager.textButtonTextStyle),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const imageSize = 50.0;

  static const memberCardPadding = EdgeInsets.symmetric(vertical: 10);

  static const memberNameTextStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const memberRoleTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );
}
