import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mpma_assignment/base_stateful_page.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/constant.dart';
import 'package:mpma_assignment/model/chore_model/chore_model.dart';
import 'package:mpma_assignment/repository/chore_repository.dart';
import 'package:mpma_assignment/router/router.gr.dart';
import 'package:mpma_assignment/services/chore_services.dart';
import 'package:mpma_assignment/viewmodel/chore_view_model.dart';
import 'package:mpma_assignment/viewmodel/user_view_model.dart';
import 'package:mpma_assignment/widget/chore_card.dart';
import 'package:mpma_assignment/widget/custom_app_bar.dart';
import 'package:mpma_assignment/widget/custom_sort_by.dart';
import 'package:mpma_assignment/widget/no_data_widget.dart';
import 'package:mpma_assignment/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';

@RoutePage()
class MyTaskScreen extends StatelessWidget {
  const MyTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return ChoreViewModel(
          choreRepository: ChoreRepository(choreServices: ChoreServices()),
        );
      },
      child: _MyTaskScreen(),
    );
  }
}

class _MyTaskScreen extends BaseStatefulPage {
  @override
  State<_MyTaskScreen> createState() => _MyTaskScreenState();
}

class _MyTaskScreenState extends BaseStatefulState<_MyTaskScreen> {
  bool _isLoading = true;
  String? selectedValue;
  final filterItems = FilterItems.taskFilterItems;
  late final tabsRouter = AutoTabsRouter.of(context);

  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
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
  PreferredSizeWidget? appbar() {
    return CustomAppBar(title: 'My Tasks', isBackButtonVisible: false);
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  Widget body() {
    final choreList = context.select(
      (ChoreViewModel vm) => vm.choreList.where(isMatch).toList(),
    );

    final loadingList = List.generate(5, (index) {
      return ChoreModel(title: 'Loading...');
    });

    return Column(
      children: [
        getFilterOption(),
        SizedBox(height: 20),
        Expanded(
          child: AdaptiveWidgets.buildRefreshableScrollView(
            context,
            onRefresh: fetchData,
            color: ColorManager.blackColor,
            refreshIndicatorBackgroundColor: ColorManager.whiteColor,
            slivers: [
              ...getChoreList(choreList: _isLoading ? loadingList : choreList),
            ],
          ),
        ),
      ],
    );
  }
}

// * ---------------------------- Helpers ----------------------------
extension _Helpers on _MyTaskScreenState {
  bool isMatch(ChoreModel chore) {
    final matchesFilter =
        selectedValue == null ||
        selectedValue == filterItems.first ||
        chore.status == selectedValue;

    return matchesFilter;
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _MyTaskScreenState {
  void _onTabChanged() {
    if (tabsRouter.activeIndex == 3) {
      _setState(() {
        selectedValue = filterItems.first;
      });
      fetchData();
    }
  }

  Future<void> fetchData() async {
    _setState(() {
      selectedValue = filterItems.first;
      _isLoading = true;
    });

    final userID = context.read<UserViewModel>().user?.userID ?? '';

    await tryCatch(
      context,
      () => context.read<ChoreViewModel>().getChoresByUserID(userID: userID),
    );

    _setState(() {
      _isLoading = false;
    });
  }

  void onFilterChanged(String? value) {
    _setState(() {
      selectedValue = value;
    });
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
extension _WidgetFactories on _MyTaskScreenState {
  Widget getFilterOption() {
    return CustomSortBy(
      sortByItems: filterItems,
      selectedValue: selectedValue,
      onChanged: (String? value) {
        onFilterChanged(value);
      },
      isExpanded: true,
      needBorder: true,
    );
  }

  List<Widget> getChoreList({required List<ChoreModel> choreList}) {
    if (choreList.isEmpty && !_isLoading) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: NoDataAvailableLabel(noDataText: 'No tasks available.'),
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
                needAssignedNames: false,
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
