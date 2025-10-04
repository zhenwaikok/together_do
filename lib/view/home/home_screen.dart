import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mpma_assignment/base_stateful_page.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/constant.dart';
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
import 'package:mpma_assignment/utils/shared_preference_handler.dart';
import 'package:mpma_assignment/viewmodel/home_screen_view_model.dart';
import 'package:mpma_assignment/viewmodel/user_view_model.dart';
import 'package:mpma_assignment/widget/chore_card.dart';
import 'package:mpma_assignment/widget/custom_app_bar.dart';
import 'package:mpma_assignment/widget/custom_card.dart';
import 'package:mpma_assignment/widget/custom_floating_action_button.dart';
import 'package:mpma_assignment/widget/custom_profile_image.dart';
import 'package:mpma_assignment/widget/no_data_widget.dart';
import 'package:mpma_assignment/widget/space_card.dart';
import 'package:mpma_assignment/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        UserViewModel(
          userRepository: UserRepository(
            sharedPreferenceHandler: SharedPreferenceHandler(),
            userServices: UserServices(),
          ),
        );
        HomeScreenViewModel(
          choreRepository: ChoreRepository(choreServices: ChoreServices()),
          spaceRepository: SpaceRepository(spaceServices: SpaceServices()),
        );
      },
      child: _HomeScreen(),
    );
  }
}

class _HomeScreen extends BaseStatefulPage {
  @override
  State<_HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseStatefulState<_HomeScreen> {
  bool _isLoading = true;
  UserModel? userDetails;
  final choreStatus = FilterItems.taskFilterItems;
  late final tabsRouter = AutoTabsRouter.of(context);

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabsRouter.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    tabsRouter.removeListener(_onTabChanged);
    super.dispose();
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return StylesManager.zeroPadding;
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Welcome, ${userDetails?.firstName ?? '-'}',
      isBackButtonVisible: false,
      actions: [
        Padding(
          padding: _Styles.profileImageRightPadding,
          child: getProfileImage(imageURL: userDetails?.profileImageURL ?? ''),
        ),
      ],
    );
  }

  @override
  Widget floatingActionButton() {
    return getFloatingActionButton();
  }

  @override
  Widget body() {
    final choreList = context.select((HomeScreenViewModel vm) => vm.choreList);
    final upcomingChoreList = upcomingChore(choreList: choreList);
    final pendingChoreList = pendingChore(choreList: choreList);
    final inProgressChoreList = inProgressChore(choreList: choreList);
    final completedChoreList = completedChore(choreList: choreList);
    final spaceList = context
        .select((HomeScreenViewModel vm) => vm.spaceList)
        .take(5)
        .toList();

    final loadingSpaceList = List.generate(5, (index) => SpaceModel());
    final loadingChoreList = List.generate(5, (index) {
      return ChoreModel(title: 'Loading...');
    });

    return AdaptiveWidgets.buildRefreshableScrollView(
      context,
      onRefresh: fetchData,
      color: ColorManager.blackColor,
      refreshIndicatorBackgroundColor: ColorManager.whiteColor,
      slivers: [
        SliverToBoxAdapter(
          child: getChoresOverviewSection(
            numOfPending: pendingChoreList.length,
            numOfInProgress: inProgressChoreList.length,
            numOfCompleted: completedChoreList.length,
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 50)),
        SliverToBoxAdapter(
          child: getUpcomingDeadlinesSection(
            upcomingChoreList: _isLoading
                ? loadingChoreList
                : upcomingChoreList,
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 50)),
        SliverToBoxAdapter(
          child: getSpacesSection(
            spaceList: _isLoading ? loadingSpaceList : spaceList,
          ),
        ),
      ],
    );
  }
}

// * ---------------------------- Helpers ----------------------------
extension _Helpers on _HomeScreenState {
  List<ChoreModel> pendingChore({required List<ChoreModel> choreList}) {
    return choreList.where((chore) {
      return chore.status == choreStatus[1];
    }).toList();
  }

  List<ChoreModel> inProgressChore({required List<ChoreModel> choreList}) {
    return choreList.where((chore) {
      return chore.status == choreStatus[2];
    }).toList();
  }

  List<ChoreModel> completedChore({required List<ChoreModel> choreList}) {
    return choreList.where((chore) {
      return chore.status == choreStatus[3];
    }).toList();
  }

  List<ChoreModel> upcomingChore({required List<ChoreModel> choreList}) {
    final now = DateTime.now();
    return choreList.where((chore) {
      return chore.dueDate!.isAfter(now) && chore.status == choreStatus[1];
    }).toList()..sort((a, b) => a.dueDate!.compareTo(b.dueDate!));
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _HomeScreenState {
  void _onTabChanged() {
    if (tabsRouter.activeIndex == 0) {
      fetchData();
    }
  }

  void onAddFABPressed() {
    context.router.push(CreateEditChoreRoute(isEdit: false));
  }

  Future<void> fetchData() async {
    _setState(() {
      _isLoading = true;
    });

    final currentUserDetails = context.read<UserViewModel>().user;

    await fetchChoreData(userID: currentUserDetails?.userID ?? '');
    await fetchSpaceData(userID: currentUserDetails?.userID ?? '');

    _setState(() {
      userDetails = currentUserDetails;
      _isLoading = false;
    });
  }

  Future<void> fetchChoreData({required String userID}) async {
    await tryCatch(
      context,
      () =>
          context.read<HomeScreenViewModel>().getChoresByUserID(userID: userID),
    );
  }

  Future<void> fetchSpaceData({required String userID}) async {
    await tryCatch(
      context,
      () =>
          context.read<HomeScreenViewModel>().getSpaceByUserID(userID: userID),
    );
  }

  void onChoreShowAllPressed() {
    AutoTabsRouter.of(context).setActiveIndex(1);
  }

  void onSpaceCardPressed({required String spaceID}) async {
    final result = await context.router.push(
      SpaceDetailsRoute(spaceID: spaceID),
    );

    if (result == true && mounted) {
      await fetchData();
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
extension _WidgetFactories on _HomeScreenState {
  Widget getProfileImage({required String imageURL}) {
    return CustomProfileImage(
      imageURL: imageURL,
      imageSize: _Styles.profileImageSize,
    );
  }

  Widget getFloatingActionButton() {
    return CustomFloatingActionButton(
      icon: Icon(Icons.add, color: ColorManager.whiteColor),
      onPressed: onAddFABPressed,
      heroTag: 'chores_fab',
    );
  }

  Widget getChoresOverviewSection({
    required int numOfPending,
    required int numOfInProgress,
    required int numOfCompleted,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Chores Overview', style: _Styles.titleTextStyle),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: getChoreStatCard(
                count: numOfPending,
                choreStatus: 'Pending',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: getChoreStatCard(
                count: numOfInProgress,
                choreStatus: 'In Progress',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: getChoreStatCard(
                count: numOfCompleted,
                choreStatus: 'Completed',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getChoreStatCard({required int count, required String choreStatus}) {
    return Skeletonizer(
      enabled: _isLoading,
      child: CustomCard(
        backgroundColor: ColorManager.primary4,
        needBoxShadow: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$count', style: _Styles.choreCountTextStyle),
            Padding(
              padding: _Styles.dividerPadding,
              child: Divider(color: ColorManager.blackColor),
            ),
            Text(
              choreStatus,
              style: _Styles.choreStatusTextStyle,
              maxLines: StylesManager.maxTextLines1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget getUpcomingDeadlinesSection({
    required List<ChoreModel> upcomingChoreList,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Upcoming Deadlines', style: _Styles.titleTextStyle),
        SizedBox(height: 10),
        getChoreList(choreList: upcomingChoreList),
      ],
    );
  }

  Widget getChoreList({required List<ChoreModel> choreList}) {
    if (choreList.isEmpty) {
      return Center(
        child: NoDataAvailableLabel(noDataText: 'No upcoming deadlines.'),
      );
    }

    return SizedBox(
      height: _Styles.choreListViewHeight,
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
                isLoading: _isLoading,
                chore: chore,
                needRightPadding: true,
                needAssignedNames: false,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getSpacesSection({required List<SpaceModel> spaceList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Spaces', style: _Styles.titleTextStyle),
            TouchableOpacity(
              onPressed: onChoreShowAllPressed,
              child: Text('Show All', style: _Styles.showAllTextStyle),
            ),
          ],
        ),
        SizedBox(height: 10),
        getSpaceList(spaceList: spaceList),
      ],
    );
  }

  Widget getSpaceList({required List<SpaceModel> spaceList}) {
    if (spaceList.isEmpty) {
      return Center(
        child: NoDataAvailableLabel(noDataText: 'Currently not in any spaces.'),
      );
    }

    return SizedBox(
      height: _Styles.spaceListViewHeight,
      child: ListView.builder(
        padding: _Styles.choreListViewPadding,
        scrollDirection: Axis.horizontal,
        itemCount: spaceList.length,
        itemBuilder: (context, index) {
          final space = spaceList[index];

          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: TouchableOpacity(
              onPressed: () {},
              child: Padding(
                padding: _Styles.spaceCardRightPadding,
                child: SpaceCard(
                  space: space,
                  isLoading: _isLoading,
                  onPressed: () => onSpaceCardPressed(spaceID: space.id ?? ''),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  static const profileImageSize = 60.0;
  static const choreListViewHeight = 95.0;
  static const spaceListViewHeight = 180.0;

  static const profileImageRightPadding = EdgeInsets.only(right: 10);
  static const dividerPadding = EdgeInsets.symmetric(vertical: 5);
  static const spaceCardRightPadding = EdgeInsets.only(right: 20);
  static const choreListViewPadding = EdgeInsets.all(5);

  static const titleTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const choreCountTextStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.primary,
  );

  static const choreStatusTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );

  static const showAllTextStyle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.primary,
  );
}
