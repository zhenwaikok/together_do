import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mpma_assignment/base_stateful_page.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/styles_manager.dart';
import 'package:mpma_assignment/model/chore_model/chore_model.dart';
import 'package:mpma_assignment/router/router.gr.dart';
import 'package:mpma_assignment/viewmodel/chore_view_model.dart';
import 'package:mpma_assignment/viewmodel/space_member_details_view_model.dart';
import 'package:mpma_assignment/viewmodel/user_view_model.dart';
import 'package:mpma_assignment/widget/chore_card.dart';
import 'package:mpma_assignment/widget/custom_app_bar.dart';
import 'package:mpma_assignment/widget/no_data_widget.dart';
import 'package:mpma_assignment/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ChoresBySpaceScreen extends StatelessWidget {
  const ChoresBySpaceScreen({super.key, required this.spaceID});

  final String spaceID;

  @override
  Widget build(BuildContext context) {
    return _ChoresBySpaceScreen(spaceID: spaceID);
  }
}

class _ChoresBySpaceScreen extends BaseStatefulPage {
  const _ChoresBySpaceScreen({required this.spaceID});

  final String spaceID;

  @override
  State<_ChoresBySpaceScreen> createState() => _ChoresBySpaceScreenState();
}

class _ChoresBySpaceScreenState
    extends BaseStatefulState<_ChoresBySpaceScreen> {
  Map<String, String> choreAssignedNames = {};
  bool _isLoading = true;

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
      title: 'Chores',
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
    final choreList = context.select((ChoreViewModel vm) => vm.choreList);

    final loadingList = List.generate(5, (index) {
      return ChoreModel(title: 'Loading...');
    });

    return AdaptiveWidgets.buildRefreshableScrollView(
      context,
      onRefresh: fetchData,
      color: ColorManager.blackColor,
      refreshIndicatorBackgroundColor: ColorManager.whiteColor,
      slivers: [
        ...getChoreList(choreList: _isLoading ? loadingList : choreList),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ChoresBySpaceScreenState {
  void onBackButtonPressed() {
    context.router.maybePop();
  }

  Future<void> fetchData() async {
    _setState(() {
      _isLoading = true;
    });

    await tryCatch(
      context,
      () => context.read<ChoreViewModel>().getChoresBySpaceID(
        spaceID: widget.spaceID,
      ),
    );

    await populateMemberMap();

    _setState(() {
      _isLoading = false;
    });
  }

  Future<void> populateMemberMap() async {
    final currentUserID = mounted
        ? context.read<UserViewModel>().user?.userID ?? ''
        : '';

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

  void onChoreCardPressed({required ChoreModel chore}) async {
    final result = await context.router.push(
      ChoreDetailsRoute(choreTitle: chore.title ?? '', choreID: chore.id ?? ''),
    );

    if (result == true && mounted) {
      fetchData();
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ChoresBySpaceScreenState {
  List<Widget> getChoreList({required List<ChoreModel> choreList}) {
    if (choreList.isEmpty && !_isLoading) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: NoDataAvailableLabel(noDataText: 'No chores available.'),
          ),
        ),
      ];
    }

    return [
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final chore = choreList[index];

          return Padding(
            padding: _Styles.cardBottomPadding,
            child: TouchableOpacity(
              onPressed: () => onChoreCardPressed(chore: chore),
              child: ChoreCard(
                isLoading: _isLoading,
                chore: chore,
                choreAssignedNames: choreAssignedNames,
              ),
            ),
          );
        }, childCount: choreList.length),
      ),
    ];
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const cardBottomPadding = EdgeInsets.only(bottom: 10);
}
