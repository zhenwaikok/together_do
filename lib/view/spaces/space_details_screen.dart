import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpma_assignment/base_stateful_page.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/font_manager.dart';
import 'package:mpma_assignment/constant/styles_manager.dart';
import 'package:mpma_assignment/model/chore_model/chore_model.dart';
import 'package:mpma_assignment/model/space_model/space_model.dart';
import 'package:mpma_assignment/model/user_model/user_model.dart';
import 'package:mpma_assignment/repository/chore_repository.dart';
import 'package:mpma_assignment/repository/space_repository.dart';
import 'package:mpma_assignment/repository/user_repository.dart';
import 'package:mpma_assignment/router/router.gr.dart';
import 'package:mpma_assignment/services/chore_services.dart';
import 'package:mpma_assignment/services/space_services.dart';
import 'package:mpma_assignment/services/user_services.dart';
import 'package:mpma_assignment/utils/extensions/string_extension.dart';
import 'package:mpma_assignment/utils/shared_preference_handler.dart';
import 'package:mpma_assignment/utils/util.dart';
import 'package:mpma_assignment/viewmodel/chore_view_model.dart';
import 'package:mpma_assignment/viewmodel/space_member_details_view_model.dart';
import 'package:mpma_assignment/viewmodel/space_view_model.dart';
import 'package:mpma_assignment/viewmodel/user_view_model.dart';
import 'package:mpma_assignment/widget/bottom_sheet_action.dart';
import 'package:mpma_assignment/widget/chore_card.dart';
import 'package:mpma_assignment/widget/custom_bar.dart';
import 'package:mpma_assignment/widget/custom_button.dart';
import 'package:mpma_assignment/widget/custom_card.dart';
import 'package:mpma_assignment/widget/custom_image.dart';
import 'package:mpma_assignment/widget/custom_profile_image.dart';
import 'package:mpma_assignment/widget/loading_indicator.dart';
import 'package:mpma_assignment/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SpaceDetailsScreen extends StatelessWidget {
  const SpaceDetailsScreen({super.key, required this.spaceID});

  final String spaceID;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        SpaceViewModel(
          spaceRepository: SpaceRepository(spaceServices: SpaceServices()),
        );
        UserViewModel(
          userRepository: UserRepository(
            sharedPreferenceHandler: SharedPreferenceHandler(),
            userServices: UserServices(),
          ),
        );
        ChoreViewModel(
          choreRepository: ChoreRepository(choreServices: ChoreServices()),
        );
      },
      child: _SpaceDetailsScreen(spaceID: spaceID),
    );
  }
}

class _SpaceDetailsScreen extends BaseStatefulPage {
  const _SpaceDetailsScreen({required this.spaceID});

  final String spaceID;

  @override
  State<_SpaceDetailsScreen> createState() => _SpaceDetailsScreenState();
}

class _SpaceDetailsScreenState extends BaseStatefulState<_SpaceDetailsScreen> {
  bool _isLoading = true;
  bool refreshData = false;
  bool isSpaceAdmin = false;
  Map<String, String> choreAssignedNames = {};

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
  EdgeInsets bottomNavigationBarPadding() {
    return StylesManager.zeroPadding;
  }

  @override
  EdgeInsets defaultPadding() {
    return StylesManager.zeroPadding;
  }

  @override
  Widget body() {
    final spaceDetails = context.select((SpaceViewModel vm) => vm.spaceDetails);
    final creatorDetails = context.select((UserViewModel vm) => vm.userDetails);
    final choreList = context
        .select((ChoreViewModel vm) => vm.choreList)
        .take(5)
        .toList();

    if (_isLoading) {
      return LoadingIndicator();
    }

    return Stack(
      children: [
        Column(
          children: [getSpaceImage(imageURL: spaceDetails?.imageURL ?? '')],
        ),
        Positioned(top: 30, left: 15, child: getBackButton()),
        if (isSpaceAdmin) ...[
          Positioned(top: 30, right: 15, child: getMoreButton()),
        ],
        Positioned(
          top: 210,
          left: 15,
          child: getNoOfMembers(
            noOfMembers: spaceDetails?.memberUserIDs?.length ?? 0,
          ),
        ),
        Positioned(
          top: _Styles.spaceImageSize - 30,
          left: 0,
          right: 0,
          bottom: 0,
          child: getSpaceDetails(
            spaceDetails: spaceDetails ?? SpaceModel(),
            creatorDetails: creatorDetails ?? UserModel(),
            choreList: choreList,
          ),
        ),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _SpaceDetailsScreenState {
  void onBackButtonPressed() {
    context.router.maybePop(refreshData);
  }

  void onMembersPressed() async {
    final result = await context.router.push(
      MembersRoute(spaceID: widget.spaceID),
    );

    if (result == true && mounted) {
      await fetchData();
    }
  }

  void onCopyButtonPressed({required String invitationCode}) {
    Clipboard.setData(ClipboardData(text: invitationCode)).then((_) {
      WidgetUtil.showSnackBar(text: 'Copied to clipboard');
    });
  }

  void onChoreShowAllPressed() {
    context.router.push(ChoresBySpaceRoute(spaceID: widget.spaceID));
  }

  Future<void> fetchData() async {
    _setState(() {
      _isLoading = true;
    });

    final currentUserID = context.read<UserViewModel>().user?.userID ?? '';
    await getSpaceDetail(spaceID: widget.spaceID);

    final creatorUserID = mounted
        ? context.read<SpaceViewModel>().spaceDetails?.creatorUserID ?? ''
        : '';

    await getCreatorDetails(creatorUserID: creatorUserID);

    await getChoresAndAssignedName(
      spaceID: widget.spaceID,
      currentUserID: currentUserID,
    );

    _setState(() {
      isSpaceAdmin = creatorUserID == currentUserID;
      _isLoading = false;
    });
  }

  Future<void> getSpaceDetail({required String spaceID}) async {
    await tryCatch(
      context,
      () => context.read<SpaceViewModel>().getSpaceDetails(spaceID: spaceID),
    );
  }

  Future<void> getCreatorDetails({required String creatorUserID}) async {
    await tryCatch(
      context,
      () => context.read<UserViewModel>().getUserDetails(
        userID: creatorUserID,
        updateSharedPreference: false,
      ),
    );
  }

  Future<void> getChoresAndAssignedName({
    required String spaceID,
    required String currentUserID,
  }) async {
    await tryCatch(
      context,
      () => context.read<ChoreViewModel>().getChoresBySpaceID(spaceID: spaceID),
    );

    final choreList = mounted
        ? context.read<ChoreViewModel>().choreList
        : <ChoreModel>[];

    if (choreList.isNotEmpty) {
      for (final chore in choreList) {
        if (mounted) {
          await tryCatch(
            context,
            () => context.read<SpaceMemberDetailsViewModel>().getMemberDetails(
              userID: chore.assignedUserID ?? '',
              updateSharedPreference: false,
            ),
          );

          final assignedUser = mounted
              ? context.read<SpaceMemberDetailsViewModel>().userDetails
              : null;

          if (assignedUser != null) {
            choreAssignedNames[chore.id ??
                ''] = currentUserID == assignedUser.userID
                ? '${assignedUser.firstName} ${assignedUser.lastName} (You)'
                : '${assignedUser.firstName} ${assignedUser.lastName}';
          }
        }
      }
    }
  }

  void onMoreButtonPressed() {
    showModalBottomSheet(
      backgroundColor: ColorManager.whiteColor,
      context: context,
      builder: (context) {
        return getBottomSheet();
      },
    );
  }

  void onEditPressed({required String spaceID}) async {
    await context.router.maybePop();
    if (mounted) {
      final result = await context.router.push(
        CreateEditSpaceRoute(isEdit: true, spaceID: spaceID),
      );

      if (result == true && mounted) {
        _setState(() {
          refreshData = true;
        });
        await fetchData();
      }
    }
  }

  void onRemovePressed({required String spaceID}) async {
    await context.router.maybePop();
    if (mounted) {
      WidgetUtil.showAlertDialog(
        context,
        title: 'Delete Confirmation',
        content:
            'Are you sure you want to delete this space? All chores in this space will be removed.',
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
              deleteSpace();
            },
            text: 'Yes',
          ),
        ],
      );
    }
  }

  void onChoreCardPressed({required ChoreModel chore}) async {
    final leaveSpaceResult = await context.router.push(
      ChoreDetailsRoute(choreID: chore.id ?? '', choreTitle: chore.title ?? ''),
    );

    if (leaveSpaceResult == true && mounted) {
      await fetchData();
    }
  }

  void onBottomButtonPressed() async {
    if (mounted) {
      WidgetUtil.showAlertDialog(
        context,
        title: isSpaceAdmin ? 'Delete Confirmation' : 'Leave Confirmation',
        content: isSpaceAdmin
            ? 'Are you sure you want to delete this space? All chores in this space will be removed.'
            : 'Are you sure you want to leave this space? All chores assigned to you in this space will be removed.',
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
              isSpaceAdmin ? deleteSpace() : leaveSpace();
            },
            text: 'Yes',
          ),
        ],
      );
    }
  }

  void deleteSpace() async {
    final deleteSpaceChoresResult =
        await tryLoad(
          context,
          () => context.read<ChoreViewModel>().deleteChore(
            spaceID: widget.spaceID,
          ),
        ) ??
        false;

    if (deleteSpaceChoresResult && mounted) {
      final deleteSpaceResult =
          await tryLoad(
            context,
            () => context.read<SpaceViewModel>().deleteSpace(
              spaceID: widget.spaceID,
            ),
          ) ??
          false;

      if (deleteSpaceResult) {
        if (mounted) await context.router.maybePop(true);
        unawaited(WidgetUtil.showSnackBar(text: 'Space removed successfully.'));
      }
    }
  }

  void leaveSpace() async {
    final userID = context.read<UserViewModel>().user?.userID ?? '';

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
        if (mounted) await context.router.maybePop(true);
        unawaited(WidgetUtil.showSnackBar(text: 'Left space successfully.'));
      }
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _SpaceDetailsScreenState {
  Widget getSpaceImage({required String imageURL}) {
    return CustomImage(
      imageSize: _Styles.spaceImageSize,
      imageWidth: double.infinity,
      imageURL: imageURL,
    );
  }

  Widget getBackButton() {
    return getTopButton(
      icon: Icons.arrow_back_rounded,
      onPressed: onBackButtonPressed,
    );
  }

  Widget getMoreButton() {
    return getTopButton(
      icon: Icons.more_vert_rounded,
      onPressed: onMoreButtonPressed,
    );
  }

  Widget getTopButton({required IconData icon, required Function() onPressed}) {
    return Container(
      width: _Styles.buttonContainerSize,
      height: _Styles.buttonContainerSize,
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: IconButton(
          icon: Icon(icon, color: ColorManager.blackColor),
          onPressed: onPressed,
        ),
      ),
    );
  }

  Widget getNoOfMembers({required int noOfMembers}) {
    return TouchableOpacity(
      onPressed: onMembersPressed,
      child: CustomBar(
        backgroundColor: ColorManager.blackColor.withValues(alpha: 0.7),
        child: Row(
          children: [
            Icon(Icons.people_alt_rounded, color: ColorManager.whiteColor),
            SizedBox(width: 5),
            Text(
              noOfMembers > 1 ? '$noOfMembers Members' : '$noOfMembers Member',
              style: _Styles.whiteTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget getSpaceDetails({
    required UserModel creatorDetails,
    required SpaceModel spaceDetails,
    required List<ChoreModel> choreList,
  }) {
    return CustomCard(
      borderRadius: _Styles.detailsCardBorderRadius,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getSpaceNameCreatedDate(
              spaceName: spaceDetails.name ?? '',
              creationDate: spaceDetails.createdAt ?? DateTime.now(),
            ),
            SizedBox(height: 5),
            getDivider(),
            SizedBox(height: 15),
            getSpaceCreator(creatorDetails: creatorDetails),
            SizedBox(height: 15),
            getSpaceDescription(description: spaceDetails.description ?? ''),
            SizedBox(height: 25),
            getChoresSection(choreList: choreList),
            SizedBox(height: 15),
            getDivider(),
            SizedBox(height: 5),
            getInvitationCode(
              invitationCode: spaceDetails.invitationCode ?? '',
            ),
            SizedBox(height: 30),
            getBottomButton(),
          ],
        ),
      ),
    );
  }

  Widget getSpaceNameCreatedDate({
    required String spaceName,
    required DateTime creationDate,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(spaceName, style: _Styles.spaceNameTextStyle),
        SizedBox(height: 10),
        Text(
          'Created on ${StringExtension.dateFormatter(creationDate)}',
          style: _Styles.smallGreyTextStyle,
        ),
      ],
    );
  }

  Widget getDivider() {
    return Divider(color: ColorManager.lightGreyColor);
  }

  Widget getSpaceCreator({required UserModel? creatorDetails}) {
    return Row(
      children: [
        CustomProfileImage(
          imageSize: _Styles.profileImageSize,
          imageURL: creatorDetails?.profileImageURL ?? '',
        ),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Created by', style: _Styles.smallGreyTextStyle),
            Text(
              isSpaceAdmin
                  ? 'You'
                  : '${creatorDetails?.firstName ?? ''} ${creatorDetails?.lastName ?? ''}',
              style: _Styles.blackTextStyle,
              maxLines: StylesManager.maxTextLines1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }

  Widget getSpaceDescription({required String description}) {
    return Text(
      description,
      textAlign: TextAlign.justify,
      style: _Styles.descriptionTextStyle,
    );
  }

  Widget getChoresSection({required List<ChoreModel> choreList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Chores', style: _Styles.blackTextStyle),
            TouchableOpacity(
              onPressed: onChoreShowAllPressed,
              child: Text('Show All', style: _Styles.showAllTextStyle),
            ),
          ],
        ),
        SizedBox(height: 10),
        getChoreList(choreList: choreList),
      ],
    );
  }

  Widget getChoreList({required List<ChoreModel> choreList}) {
    if (choreList.isEmpty) {
      return Text('No chores available.', style: _Styles.descriptionTextStyle);
    }

    return SizedBox(
      height: _Styles.listViewHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: choreList.length,
        itemBuilder: (context, index) {
          final chore = choreList[index];

          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TouchableOpacity(
              onPressed: () => onChoreCardPressed(chore: chore),
              child: ChoreCard(
                chore: chore,
                choreAssignedNames: choreAssignedNames,
                needRightPadding: true,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getInvitationCode({required String invitationCode}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Space Invitation Code:', style: _Styles.blackTextStyle),
        Row(
          children: [
            Text(
              invitationCode,
              style: _Styles.descriptionTextStyle,
              maxLines: StylesManager.maxTextLines1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(width: 5),
            TouchableOpacity(
              onPressed: () =>
                  onCopyButtonPressed(invitationCode: invitationCode),
              child: Icon(
                Icons.copy,
                size: _Styles.iconSize,
                color: ColorManager.greyColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getBottomButton() {
    return CustomButton(
      text: isSpaceAdmin ? 'Delete Space' : 'Leave Space',
      backgroundColor: ColorManager.redColor,
      textColor: ColorManager.whiteColor,
      onPressed: onBottomButtonPressed,
    );
  }

  Widget getBottomSheet() {
    return Padding(
      padding: StylesManager.screenPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetAction(
            icon: Icons.edit,
            color: ColorManager.blackColor,
            text: 'Edit',
            onTap: () => onEditPressed(spaceID: widget.spaceID),
          ),
          SizedBox(height: 10),
          BottomSheetAction(
            icon: Icons.delete_outline,
            color: ColorManager.redColor,
            text: 'Remove',
            onTap: () => onRemovePressed(spaceID: widget.spaceID),
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

  static const spaceImageSize = 300.0;
  static const buttonContainerSize = 50.0;
  static const profileImageSize = 60.0;
  static const iconSize = 15.0;
  static const listViewHeight = 135.0;

  static const whiteTextStyle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.whiteColor,
  );

  static const detailsCardBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(30),
    topRight: Radius.circular(30),
  );

  static const spaceNameTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const smallGreyTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const blackTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const descriptionTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const showAllTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.primary,
  );
}
