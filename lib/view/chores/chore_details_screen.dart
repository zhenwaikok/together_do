import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mpma_assignment/base_stateful_page.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/constant.dart';
import 'package:mpma_assignment/constant/font_manager.dart';
import 'package:mpma_assignment/constant/styles_manager.dart';
import 'package:mpma_assignment/model/chore_model/chore_model.dart';
import 'package:mpma_assignment/repository/chore_repository.dart';
import 'package:mpma_assignment/router/router.gr.dart';
import 'package:mpma_assignment/services/chore_services.dart';
import 'package:mpma_assignment/utils/extensions/string_extension.dart';
import 'package:mpma_assignment/utils/util.dart';
import 'package:mpma_assignment/viewmodel/chore_view_model.dart';
import 'package:mpma_assignment/viewmodel/space_member_details_view_model.dart';
import 'package:mpma_assignment/viewmodel/space_view_model.dart';
import 'package:mpma_assignment/viewmodel/user_view_model.dart';
import 'package:mpma_assignment/widget/bottom_sheet_action.dart';
import 'package:mpma_assignment/widget/custom_app_bar.dart';
import 'package:mpma_assignment/widget/custom_bar.dart';
import 'package:mpma_assignment/widget/custom_button.dart';
import 'package:mpma_assignment/widget/custom_image.dart';
import 'package:mpma_assignment/widget/custom_profile_image.dart';
import 'package:mpma_assignment/widget/loading_indicator.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ChoreDetailsScreen extends StatelessWidget {
  const ChoreDetailsScreen({
    super.key,
    required this.choreTitle,
    required this.choreID,
  });

  final String choreTitle;
  final String choreID;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChoreViewModel(
        choreRepository: ChoreRepository(choreServices: ChoreServices()),
      ),
      child: _ChoreDetailsScreen(choreTitle: choreTitle, choreID: choreID),
    );
  }
}

class _ChoreDetailsScreen extends BaseStatefulPage {
  const _ChoreDetailsScreen({required this.choreTitle, required this.choreID});

  final String choreTitle;
  final String choreID;

  @override
  State<_ChoreDetailsScreen> createState() => _ChoreDetailsScreenState();
}

class _ChoreDetailsScreenState extends BaseStatefulState<_ChoreDetailsScreen> {
  bool _isLoading = true;
  bool isChoreAssignedToCurrentUser = false;
  ChoreModel? choreDetails;
  final choreStatus = FilterItems.taskFilterItems;
  bool refreshData = false;
  bool isChoreCreator = false;

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
      title: widget.choreTitle,
      onPressed: onBackButtonPressed,
      isBackButtonVisible: true,
      actions: [
        choreDetails?.status == FilterItems.taskFilterItems[1] && isChoreCreator
            ? getMoreButton()
            : StylesManager.emptyWidget,
      ],
    );
  }

  @override
  Widget bottomNavigationBar() {
    return _isLoading
        ? StylesManager.emptyWidget
        : isChoreAssignedToCurrentUser
        ? getBottomButton(choreDetails: choreDetails ?? ChoreModel())
        : StylesManager.emptyWidget;
  }

  @override
  Widget body() {
    choreDetails = context.select((ChoreViewModel vm) => vm.choreDetails);
    final space = context.select((SpaceViewModel vm) => vm.spaceDetails);
    final assignedUser = context.select(
      (SpaceMemberDetailsViewModel vm) => vm.userDetails,
    );
    final isCompleted = choreDetails?.status == FilterItems.taskFilterItems[3];

    if (_isLoading) {
      return LoadingIndicator();
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getChoreImage(imageURL: choreDetails?.photoURL ?? ''),
          SizedBox(height: 15),
          getChoreStatus(
            status: choreDetails?.status ?? '',
            createdAt: choreDetails?.createdAt ?? DateTime.now(),
          ),
          SizedBox(height: 25),
          getSpaceName(spaceName: space?.name ?? ''),
          SizedBox(height: 20),
          getAssignedMember(
            assignedUser: isChoreAssignedToCurrentUser
                ? 'You'
                : '${assignedUser?.firstName ?? ''} ${assignedUser?.lastName ?? ''}',
            profileImageURL: assignedUser?.profileImageURL ?? '',
          ),
          SizedBox(height: 20),
          getDueDate(dueDate: choreDetails?.dueDate ?? DateTime.now()),
          SizedBox(height: 30),
          getChoreTitle(),
          SizedBox(height: 20),
          getChoreDescription(description: choreDetails?.description ?? ''),
          if (isCompleted) ...[
            SizedBox(height: 20),
            getCompletedOn(
              completedOn: choreDetails?.completedAt ?? DateTime.now(),
            ),
          ],
        ],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ChoreDetailsScreenState {
  void onBackButtonPressed() {
    context.router.maybePop(refreshData);
  }

  Future<void> fetchData() async {
    _setState(() {
      _isLoading = true;
    });
    await tryCatch(
      context,
      () => context.read<ChoreViewModel>().getChoreDetails(
        choreID: widget.choreID,
      ),
    );

    final currentUserID = mounted
        ? context.read<UserViewModel>().user?.userID ?? ''
        : '';

    final choreDetails = mounted
        ? context.read<ChoreViewModel>().choreDetails
        : null;

    if (mounted) {
      await tryCatch(
        context,
        () => context.read<SpaceMemberDetailsViewModel>().getMemberDetails(
          userID: choreDetails?.assignedUserID ?? '',
          updateSharedPreference: false,
        ),
      );
    }

    final spaceID = mounted
        ? context.read<ChoreViewModel>().choreDetails?.spaceID ?? ''
        : '';

    if (mounted) {
      await tryCatch(
        context,
        () => context.read<SpaceViewModel>().getSpaceDetails(spaceID: spaceID),
      );
    }

    _setState(() {
      isChoreAssignedToCurrentUser =
          currentUserID == (choreDetails?.assignedUserID ?? '');
      isChoreCreator = currentUserID == (choreDetails?.creatorUserID ?? '');
      _isLoading = false;
    });
  }

  void onButtonPressed({required ChoreModel choreDetails}) {
    WidgetUtil.showAlertDialog(
      context,
      title: 'Confirmation',
      content: StringExtension.getAlertDialogContentLabel(
        choreDetails.status ?? '',
      ),
      actions: [
        (dialogContext) => getAlertDialogTextButton(
          onPressed: () {
            Navigator.of(dialogContext).pop();
          },
          text: 'No',
        ),
        (dialogContext) => getAlertDialogTextButton(
          onPressed: () async {
            Navigator.of(dialogContext).pop();
            onYesPressed(choreDetails: choreDetails);
          },
          text: 'Yes',
        ),
      ],
    );
  }

  void onYesPressed({required ChoreModel choreDetails}) {
    if (choreDetails.status == choreStatus[1]) {
      onDoingChorePressed(choreDetails: choreDetails);
    } else if (choreDetails.status == choreStatus[2]) {
      onCompleteChorePressed(choreDetails: choreDetails);
    } else {
      () {};
    }
  }

  void onDoingChorePressed({required ChoreModel choreDetails}) async {
    await updateChoreStatus(choreDetails: choreDetails, status: 'In Progress');
  }

  void onCompleteChorePressed({required ChoreModel choreDetails}) async {
    await updateChoreStatus(
      choreDetails: choreDetails,
      status: 'Completed',
      completedAt: DateTime.now(),
    );
  }

  Future<void> updateChoreStatus({
    required ChoreModel choreDetails,
    required String status,
    DateTime? completedAt,
  }) async {
    final result =
        await tryLoad(
          context,
          () => context.read<ChoreViewModel>().updateChore(
            choreDetails: choreDetails,
            status: status,
            completedAt: completedAt,
          ),
        ) ??
        false;

    if (result) {
      _setState(() {
        refreshData = true;
      });
      await fetchData();
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

  void onEditPressed({required String choreID}) async {
    await context.router.maybePop();
    if (mounted) {
      final result = await context.router.push(
        CreateEditChoreRoute(isEdit: true, choreID: choreID),
      );

      if (result == true && mounted) {
        _setState(() {
          refreshData = true;
        });
        await fetchData();
      }
    }
  }

  void onRemovePressed({required String choreID}) async {
    await context.router.maybePop();
    if (mounted) {
      WidgetUtil.showAlertDialog(
        context,
        title: 'Delete Confirmation',
        content: 'Are you sure you want to delete this chore?',
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
              deleteChore(choreID: choreID);
            },
            text: 'Yes',
          ),
        ],
      );
    }
  }

  void deleteChore({required String choreID}) async {
    final result =
        await tryLoad(
          context,
          () => context.read<ChoreViewModel>().deleteChore(choreID: choreID),
        ) ??
        false;

    if (result) {
      if (mounted) await context.router.maybePop(true);
      unawaited(WidgetUtil.showSnackBar(text: 'Chore removed successfully.'));
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ChoreDetailsScreenState {
  Widget getMoreButton() {
    return IconButton(
      icon: Icon(Icons.more_vert, color: ColorManager.blackColor),
      onPressed: onMoreButtonPressed,
    );
  }

  Widget getChoreImage({required String imageURL}) {
    return CustomImage(
      imageURL: imageURL,
      imageWidth: double.infinity,
      imageSize: _Styles.choreImageHeight,
    );
  }

  Widget getChoreStatus({required String status, required DateTime createdAt}) {
    final backgroundColor = WidgetUtil.getChoreStatusColor(status);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomBar(
          backgroundColor: backgroundColor,
          child: Text(status, style: _Styles.whiteTextStyle),
        ),
        SizedBox(width: 20),
        getCreationPeriod(createdAt: createdAt),
      ],
    );
  }

  Widget getCreationPeriod({required DateTime createdAt}) {
    return Row(
      children: [
        Icon(
          Icons.access_time,
          size: _Styles.iconSize,
          color: ColorManager.greyColor,
        ),
        SizedBox(width: 5),
        Text(
          'Created ${StringExtension.differenceBetweenDate(createdAt)}',
          style: _Styles.smallGreyTextStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget getSpaceName({required String spaceName}) {
    return Text(
      'For space: $spaceName',
      style: _Styles.regularBlackTextStyle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget getAssignedMember({
    required String assignedUser,
    required String profileImageURL,
  }) {
    return Row(
      children: [
        Text(
          'Assigned to: $assignedUser',
          style: _Styles.regularBlackTextStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(width: 5),
        CustomProfileImage(
          imageURL: profileImageURL,
          imageSize: _Styles.profileImageSize,
        ),
      ],
    );
  }

  Widget getDueDate({required DateTime dueDate}) {
    return Text(
      'Due: ${StringExtension.dateToDayFormatter(dueDate)}, ${StringExtension.dateFormatter(dueDate)}',
      style: _Styles.regularBlackTextStyle,
    );
  }

  Widget getChoreTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Chore Title', style: _Styles.boldTitleTextStyle),
        SizedBox(height: 5),
        Text(widget.choreTitle, style: _Styles.choreTitleTextStyle),
      ],
    );
  }

  Widget getChoreDescription({required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: _Styles.boldTitleTextStyle),
        SizedBox(height: 5),
        Text(
          description,
          style: _Styles.regularBlackTextStyle,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget getCompletedOn({required DateTime completedOn}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Completed On', style: _Styles.boldTitleTextStyle),
        SizedBox(height: 5),
        Row(
          children: [
            Icon(
              Icons.calendar_month,
              size: _Styles.calendarIconSize,
              color: ColorManager.primary,
            ),
            SizedBox(width: 5),
            Text(
              '${StringExtension.dateToDayFormatter(completedOn)}, ${StringExtension.dateFormatter(completedOn)}',
              style: _Styles.regularBlackTextStyle,
            ),
          ],
        ),
      ],
    );
  }

  Widget getBottomButton({required ChoreModel choreDetails}) {
    if (choreDetails.status == choreStatus[3]) {
      return StylesManager.emptyWidget;
    }

    return CustomButton(
      text: StringExtension.getButtonLabel(choreDetails.status ?? ''),
      textColor: ColorManager.whiteColor,
      onPressed: () => onButtonPressed(choreDetails: choreDetails),
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
            onTap: () => onEditPressed(choreID: widget.choreID),
          ),
          SizedBox(height: 10),
          BottomSheetAction(
            icon: Icons.delete_outline,
            color: ColorManager.redColor,
            text: 'Remove',
            onTap: () => onRemovePressed(choreID: widget.choreID),
          ),
        ],
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const iconSize = 15.0;
  static const calendarIconSize = 25.0;
  static const profileImageSize = 30.0;
  static const choreImageHeight = 200.0;

  static const whiteTextStyle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.whiteColor,
  );

  static const smallGreyTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.greyColor,
  );

  static const boldTitleTextStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const choreTitleTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const regularBlackTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );
}
