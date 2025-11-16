import 'package:adaptive_widgets_flutter/adaptive_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mpma_assignment/base_stateful_page.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/font_manager.dart';
import 'package:mpma_assignment/constant/styles_manager.dart';
import 'package:mpma_assignment/model/user_model/user_model.dart';
import 'package:mpma_assignment/router/router.gr.dart';
import 'package:mpma_assignment/viewmodel/profile_screen_view_model.dart';
import 'package:mpma_assignment/viewmodel/user_view_model.dart';
import 'package:mpma_assignment/widget/custom_app_bar.dart';
import 'package:mpma_assignment/widget/custom_profile_image.dart';
import 'package:mpma_assignment/widget/touchable_capacity.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileScreenViewModel>(
      create: (context) => ProfileScreenViewModel(
        userRepository: context.read<UserViewModel>().userRepository,
      ),
      child: _ProfileScreen(),
    );
  }
}

class _ProfileScreen extends BaseStatefulPage {
  @override
  State<_ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseStatefulState<_ProfileScreen> {
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
    return CustomAppBar(title: 'My Profile', isBackButtonVisible: false);
  }

  @override
  EdgeInsets defaultPadding() {
    return EdgeInsets.zero;
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  Widget body() {
    final user =
        context.select((ProfileScreenViewModel vm) => vm.userDetails) ??
        context.read<UserViewModel>().user ??
        UserModel();

    return AdaptiveWidgets.buildRefreshableScrollView(
      context,
      onRefresh: fetchData,
      color: ColorManager.blackColor,
      refreshIndicatorBackgroundColor: ColorManager.whiteColor,
      slivers: [
        SliverPadding(
          padding: StylesManager.screenPadding,
          sliver: SliverMainAxisGroup(
            slivers: [
              SliverToBoxAdapter(child: getProfileDetails(user: user)),
              SliverToBoxAdapter(child: SizedBox(height: 60)),
              SliverToBoxAdapter(child: getProfileActionSection()),
            ],
          ),
        ),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ProfileScreenState {
  Future<void> onSignOutPressed() async {
    ZegoUIKitPrebuiltCallInvitationService().uninit();
    await tryLoad(context, () => context.read<UserViewModel>().logout());
  }

  Future<void> onEditProfilePressed() async {
    final userID = context.read<UserViewModel>().user?.userID ?? '';
    final result = await context.router.push(EditProfileRoute(userID: userID));

    if (result == true && mounted) {
      fetchData();
    }
  }

  void onChangePasswordPressed() {
    context.router.push(ChangePasswordRoute());
  }

  Future<void> fetchData() async {
    _setState(() {
      _isLoading = true;
    });
    final userID = context.read<UserViewModel>().user?.userID ?? '';

    await tryCatch(
      context,
      () =>
          context.read<ProfileScreenViewModel>().getUserDetails(userID: userID),
    );

    _setState(() {
      _isLoading = false;
    });
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ProfileScreenState {
  Widget getProfileDetails({required UserModel user}) {
    return Skeletonizer(
      enabled: _isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomProfileImage(
            imageURL: user.profileImageURL ?? '',
            imageSize: _Styles.imageSize,
          ),
          SizedBox(height: 20),
          Text(
            '${user.firstName ?? 'Loading...'} ${user.lastName ?? ''}',
            style: _Styles.usernameTextStyle,
          ),
        ],
      ),
    );
  }

  Widget getProfileActionSection() {
    return Column(
      children: [
        getProfileRowElement(
          icon: Icons.edit,
          text: 'Edit Profile',
          isSignOut: false,
          onPressed: onEditProfilePressed,
        ),
        getProfileRowElement(
          icon: Icons.lock_outline_rounded,
          text: 'Change Password',
          isSignOut: false,
          onPressed: onChangePasswordPressed,
        ),
        getProfileRowElement(
          icon: Icons.logout,
          text: 'Logout',
          isSignOut: true,
          onPressed: onSignOutPressed,
        ),
      ],
    );
  }

  Widget getProfileRowElement({
    required IconData icon,
    required String text,
    bool? isSignOut,
    required void Function()? onPressed,
  }) {
    return TouchableOpacity(
      onPressed: onPressed,
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: isSignOut == true
                    ? ColorManager.redColor
                    : ColorManager.blackColor,
                size: _Styles.iconSize,
              ),
              SizedBox(width: 25),
              Expanded(
                child: Text(
                  text,
                  style: _Styles.labelTextStyle(isSignOut: isSignOut ?? false),
                ),
              ),
              if (isSignOut == false)
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: ColorManager.blackColor,
                  size: _Styles.arrowIconSize,
                ),
            ],
          ),
          Padding(
            padding: _Styles.padding,
            child: Divider(
              color: ColorManager.greyColor.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const iconSize = 28.0;
  static const imageSize = 150.0;

  static const arrowIconSize = 18.0;
  static const padding = EdgeInsets.symmetric(vertical: 15);

  static TextStyle labelTextStyle({required bool isSignOut}) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeightManager.regular,
    color: isSignOut == true ? ColorManager.redColor : ColorManager.blackColor,
  );

  static const usernameTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );
}
