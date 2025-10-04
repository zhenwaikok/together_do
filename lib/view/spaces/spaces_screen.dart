import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mpma_assignment/base_stateful_page.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/enum/form_type.dart';
import 'package:mpma_assignment/constant/styles_manager.dart';
import 'package:mpma_assignment/model/space_model/space_model.dart';
import 'package:mpma_assignment/repository/space_repository.dart';
import 'package:mpma_assignment/router/router.gr.dart';
import 'package:mpma_assignment/services/space_services.dart';
import 'package:mpma_assignment/utils/util.dart';
import 'package:mpma_assignment/viewmodel/space_view_model.dart';
import 'package:mpma_assignment/viewmodel/user_view_model.dart';
import 'package:mpma_assignment/widget/bottom_sheet_action.dart';
import 'package:mpma_assignment/widget/custom_app_bar.dart';
import 'package:mpma_assignment/widget/no_data_widget.dart';
import 'package:mpma_assignment/widget/search_bar.dart';
import 'package:mpma_assignment/widget/space_card.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SpacesScreen extends StatelessWidget {
  const SpacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SpaceViewModel(
        spaceRepository: SpaceRepository(spaceServices: SpaceServices()),
      ),
      child: _SpacesScreen(),
    );
  }
}

class _SpacesScreen extends BaseStatefulPage {
  @override
  State<_SpacesScreen> createState() => _SpacesScreenState();
}

class _SpacesScreenState extends BaseStatefulState<_SpacesScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = true;
  String? searchQuery;
  TextEditingController searchController = TextEditingController();
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
    tabsRouter.addListener(_onTabChanged);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    tabsRouter.removeListener(_onTabChanged);
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return StylesManager.zeroPadding;
  }

  @override
  PreferredSizeWidget? appbar() {
    return CustomAppBar(
      title: 'Family Spaces',
      isBackButtonVisible: false,
      actions: [getMoreButton()],
    );
  }

  @override
  Widget body() {
    final spaceList = context.select(
      (SpaceViewModel vm) => vm.spaceList.where(isMatch).toList(),
    );

    final loadingList = List.generate(5, (index) => SpaceModel());

    return Column(
      children: [
        getSearchBar(controller: searchController),
        SizedBox(height: 30),
        Expanded(
          child: AdaptiveWidgets.buildRefreshableScrollView(
            context,
            onRefresh: fetchData,
            color: ColorManager.blackColor,
            refreshIndicatorBackgroundColor: ColorManager.whiteColor,
            slivers: [
              if (spaceList.isEmpty && !_isLoading) ...[
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: NoDataAvailableLabel(
                      noDataText: 'No spaces available. Create or join one!',
                    ),
                  ),
                ),
              ],
              SliverToBoxAdapter(
                child: getSpacesGrid(
                  spaceList: _isLoading ? loadingList : spaceList,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// * ---------------------------- Helper ----------------------------
extension _Helpers on _SpacesScreenState {
  String get invitationCode {
    return _formKey
            .currentState
            ?.fields[JoinSpaceFormFieldsEnum.spaceCode.name]
            ?.value ??
        '';
  }

  bool isMatch(SpaceModel space) {
    final query = searchQuery?.toLowerCase().trim() ?? '';
    final matchesSearch =
        query.isEmpty ||
        (space.name?.toLowerCase().contains(query) ?? false) ||
        (space.description?.toLowerCase().contains(query) ?? false);

    return matchesSearch;
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _SpacesScreenState {
  void _onTabChanged() {
    if (tabsRouter.activeIndex == 1) {
      resetAll();
    }
  }

  Future<void> fetchData() async {
    _setState(() => _isLoading = true);
    final userID = context.read<UserViewModel>().user?.userID ?? '';
    await tryCatch(
      context,
      () => context.read<SpaceViewModel>().getSpaceByUserID(userID: userID),
    );
    _setState(() => _isLoading = false);
  }

  void onMoreButtonPressed() async {
    showModalBottomSheet(
      backgroundColor: ColorManager.whiteColor,
      context: context,
      builder: (context) {
        return getMoreBottomSheet();
      },
    );
  }

  void onCreateSpacePressed() async {
    await context.router.maybePop();
    if (mounted) {
      final result = await context.router.push(
        CreateEditSpaceRoute(isEdit: false),
      );
      if (result == true) {
        fetchData();
      }
    }
  }

  void onJoinSpacePressed() async {
    await context.router.maybePop();
    if (mounted) {
      WidgetUtil.showAlertDialog(
        needTextField: true,
        formName: JoinSpaceFormFieldsEnum.spaceCode.name,
        validator: FormBuilderValidators.required(),
        formKey: _formKey,
        hintText: 'Space Code',
        context,
        title: 'Join space using code',
        actions: [
          (dialogContext) => getAlertDialogTextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            text: 'Cancel',
          ),
          (dialogContext) => getAlertDialogTextButton(
            onPressed: () => onJoinButtonPressed(dialogContext: dialogContext),
            text: 'Join',
          ),
        ],
      );
    }
  }

  Future<void> onJoinButtonPressed({
    required BuildContext dialogContext,
  }) async {
    final userID = context.read<UserViewModel>().user?.userID ?? '';

    final formValid = _formKey.currentState?.saveAndValidate() ?? false;
    if (formValid) {
      Navigator.of(dialogContext).pop();
      final result =
          await tryLoad(
            context,
            () => context.read<SpaceViewModel>().joinSpaceWithInvitationCode(
              invitationCode: invitationCode,
              userID: userID,
            ),
          ) ??
          false;

      if (result) {
        WidgetUtil.showSnackBar(text: 'Joined space successfully');
        await fetchData();
      } else {
        WidgetUtil.showSnackBar(text: 'No space found with the provided code');
      }
    }
  }

  void onSpaceCardPressed({required String spaceID}) async {
    final result = await context.router.push(
      SpaceDetailsRoute(spaceID: spaceID),
    );

    if (result == true && mounted) {
      await fetchData();
    }
  }

  void onSearchChanged(String? value) {
    _setState(() {
      searchQuery = value;
    });
  }

  void resetAll() {
    _setState(() {
      searchQuery = null;
      searchController.clear();
    });
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _SpacesScreenState {
  Widget getMoreButton() {
    return IconButton(
      icon: Icon(Icons.more_vert_rounded, color: ColorManager.blackColor),
      onPressed: onMoreButtonPressed,
    );
  }

  Widget getMoreBottomSheet() {
    return Padding(
      padding: StylesManager.screenPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetAction(
            icon: Icons.add,
            color: ColorManager.blackColor,
            text: 'Create Family Space',
            onTap: onCreateSpacePressed,
          ),
          SizedBox(height: 10),
          BottomSheetAction(
            icon: Icons.input_rounded,
            color: ColorManager.blackColor,
            text: 'Join With Code',
            onTap: onJoinSpacePressed,
          ),
        ],
      ),
    );
  }

  Widget getSearchBar({required TextEditingController controller}) {
    return CustomSearchBar(
      controller: controller,
      hintText: 'Search request here',
      onChanged: (value) {
        onSearchChanged(value);
      },
      onPressed: resetAll,
    );
  }

  Widget getSpacesGrid({required List<SpaceModel> spaceList}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemCount: spaceList.length,
      itemBuilder: (context, index) {
        final space = spaceList[index];
        return SpaceCard(
          space: space,
          isLoading: _isLoading,
          onPressed: () => onSpaceCardPressed(spaceID: space.id ?? ''),
        );
      },
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
