// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i22;
import 'package:flutter/material.dart' as _i23;
import 'package:mpma_assignment/router/root_navigator_screen.dart' as _i16;
import 'package:mpma_assignment/view/auth/forgot_password_screen.dart' as _i8;
import 'package:mpma_assignment/view/auth/login_screen.dart' as _i11;
import 'package:mpma_assignment/view/auth/signup_screen.dart' as _i17;
import 'package:mpma_assignment/view/chores/chore_details_screen.dart' as _i2;
import 'package:mpma_assignment/view/chores/chores_by_space_screen.dart' as _i3;
import 'package:mpma_assignment/view/chores/create_edit_chore_screen.dart'
    as _i4;
import 'package:mpma_assignment/view/home/home_screen.dart' as _i9;
import 'package:mpma_assignment/view/my_task/my_task_screen.dart' as _i13;
import 'package:mpma_assignment/view/onboarding_screen.dart' as _i14;
import 'package:mpma_assignment/view/profile/change_password_screen.dart'
    as _i1;
import 'package:mpma_assignment/view/profile/edit_profile_screen.dart' as _i7;
import 'package:mpma_assignment/view/profile/profile_screen.dart' as _i15;
import 'package:mpma_assignment/view/spaces/create_edit_space_screen.dart'
    as _i5;
import 'package:mpma_assignment/view/spaces/members_screen.dart' as _i12;
import 'package:mpma_assignment/view/spaces/space_details_screen.dart' as _i18;
import 'package:mpma_assignment/view/spaces/spaces_screen.dart' as _i19;
import 'package:mpma_assignment/view/splash_screen.dart' as _i20;
import 'package:mpma_assignment/view/tips/home_tips_screen.dart' as _i10;
import 'package:mpma_assignment/view/tips/video_player_screen.dart' as _i21;
import 'package:mpma_assignment/widget/custom_bottom_nav_bar.dart' as _i6;

/// generated route for
/// [_i1.ChangePasswordScreen]
class ChangePasswordRoute extends _i22.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i22.PageRouteInfo>? children})
    : super(ChangePasswordRoute.name, initialChildren: children);

  static const String name = 'ChangePasswordRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i1.ChangePasswordScreen();
    },
  );
}

/// generated route for
/// [_i2.ChoreDetailsScreen]
class ChoreDetailsRoute extends _i22.PageRouteInfo<ChoreDetailsRouteArgs> {
  ChoreDetailsRoute({
    _i23.Key? key,
    required String choreTitle,
    required String choreID,
    List<_i22.PageRouteInfo>? children,
  }) : super(
         ChoreDetailsRoute.name,
         args: ChoreDetailsRouteArgs(
           key: key,
           choreTitle: choreTitle,
           choreID: choreID,
         ),
         initialChildren: children,
       );

  static const String name = 'ChoreDetailsRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChoreDetailsRouteArgs>();
      return _i2.ChoreDetailsScreen(
        key: args.key,
        choreTitle: args.choreTitle,
        choreID: args.choreID,
      );
    },
  );
}

class ChoreDetailsRouteArgs {
  const ChoreDetailsRouteArgs({
    this.key,
    required this.choreTitle,
    required this.choreID,
  });

  final _i23.Key? key;

  final String choreTitle;

  final String choreID;

  @override
  String toString() {
    return 'ChoreDetailsRouteArgs{key: $key, choreTitle: $choreTitle, choreID: $choreID}';
  }
}

/// generated route for
/// [_i3.ChoresBySpaceScreen]
class ChoresBySpaceRoute extends _i22.PageRouteInfo<ChoresBySpaceRouteArgs> {
  ChoresBySpaceRoute({
    _i23.Key? key,
    required String spaceID,
    List<_i22.PageRouteInfo>? children,
  }) : super(
         ChoresBySpaceRoute.name,
         args: ChoresBySpaceRouteArgs(key: key, spaceID: spaceID),
         initialChildren: children,
       );

  static const String name = 'ChoresBySpaceRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChoresBySpaceRouteArgs>();
      return _i3.ChoresBySpaceScreen(key: args.key, spaceID: args.spaceID);
    },
  );
}

class ChoresBySpaceRouteArgs {
  const ChoresBySpaceRouteArgs({this.key, required this.spaceID});

  final _i23.Key? key;

  final String spaceID;

  @override
  String toString() {
    return 'ChoresBySpaceRouteArgs{key: $key, spaceID: $spaceID}';
  }
}

/// generated route for
/// [_i4.CreateEditChoreScreen]
class CreateEditChoreRoute
    extends _i22.PageRouteInfo<CreateEditChoreRouteArgs> {
  CreateEditChoreRoute({
    _i23.Key? key,
    required bool isEdit,
    String? choreID,
    List<_i22.PageRouteInfo>? children,
  }) : super(
         CreateEditChoreRoute.name,
         args: CreateEditChoreRouteArgs(
           key: key,
           isEdit: isEdit,
           choreID: choreID,
         ),
         initialChildren: children,
       );

  static const String name = 'CreateEditChoreRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateEditChoreRouteArgs>();
      return _i4.CreateEditChoreScreen(
        key: args.key,
        isEdit: args.isEdit,
        choreID: args.choreID,
      );
    },
  );
}

class CreateEditChoreRouteArgs {
  const CreateEditChoreRouteArgs({
    this.key,
    required this.isEdit,
    this.choreID,
  });

  final _i23.Key? key;

  final bool isEdit;

  final String? choreID;

  @override
  String toString() {
    return 'CreateEditChoreRouteArgs{key: $key, isEdit: $isEdit, choreID: $choreID}';
  }
}

/// generated route for
/// [_i5.CreateEditSpaceScreen]
class CreateEditSpaceRoute
    extends _i22.PageRouteInfo<CreateEditSpaceRouteArgs> {
  CreateEditSpaceRoute({
    _i23.Key? key,
    required bool isEdit,
    String? spaceID,
    List<_i22.PageRouteInfo>? children,
  }) : super(
         CreateEditSpaceRoute.name,
         args: CreateEditSpaceRouteArgs(
           key: key,
           isEdit: isEdit,
           spaceID: spaceID,
         ),
         initialChildren: children,
       );

  static const String name = 'CreateEditSpaceRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateEditSpaceRouteArgs>();
      return _i5.CreateEditSpaceScreen(
        key: args.key,
        isEdit: args.isEdit,
        spaceID: args.spaceID,
      );
    },
  );
}

class CreateEditSpaceRouteArgs {
  const CreateEditSpaceRouteArgs({
    this.key,
    required this.isEdit,
    this.spaceID,
  });

  final _i23.Key? key;

  final bool isEdit;

  final String? spaceID;

  @override
  String toString() {
    return 'CreateEditSpaceRouteArgs{key: $key, isEdit: $isEdit, spaceID: $spaceID}';
  }
}

/// generated route for
/// [_i6.CustomBottomNavBar]
class CustomBottomNavBar extends _i22.PageRouteInfo<void> {
  const CustomBottomNavBar({List<_i22.PageRouteInfo>? children})
    : super(CustomBottomNavBar.name, initialChildren: children);

  static const String name = 'CustomBottomNavBar';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i6.CustomBottomNavBar();
    },
  );
}

/// generated route for
/// [_i7.EditProfileScreen]
class EditProfileRoute extends _i22.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i23.Key? key,
    required String userID,
    List<_i22.PageRouteInfo>? children,
  }) : super(
         EditProfileRoute.name,
         args: EditProfileRouteArgs(key: key, userID: userID),
         initialChildren: children,
       );

  static const String name = 'EditProfileRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditProfileRouteArgs>();
      return _i7.EditProfileScreen(key: args.key, userID: args.userID);
    },
  );
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({this.key, required this.userID});

  final _i23.Key? key;

  final String userID;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, userID: $userID}';
  }
}

/// generated route for
/// [_i8.ForgotPasswordScreen]
class ForgotPasswordRoute extends _i22.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i22.PageRouteInfo>? children})
    : super(ForgotPasswordRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i8.ForgotPasswordScreen();
    },
  );
}

/// generated route for
/// [_i9.HomeScreen]
class HomeRoute extends _i22.PageRouteInfo<void> {
  const HomeRoute({List<_i22.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i9.HomeScreen();
    },
  );
}

/// generated route for
/// [_i10.HomeTipsScreen]
class HomeTipsRoute extends _i22.PageRouteInfo<void> {
  const HomeTipsRoute({List<_i22.PageRouteInfo>? children})
    : super(HomeTipsRoute.name, initialChildren: children);

  static const String name = 'HomeTipsRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i10.HomeTipsScreen();
    },
  );
}

/// generated route for
/// [_i11.LoginScreen]
class LoginRoute extends _i22.PageRouteInfo<void> {
  const LoginRoute({List<_i22.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i11.LoginScreen();
    },
  );
}

/// generated route for
/// [_i12.MembersScreen]
class MembersRoute extends _i22.PageRouteInfo<MembersRouteArgs> {
  MembersRoute({
    _i23.Key? key,
    required String spaceID,
    List<_i22.PageRouteInfo>? children,
  }) : super(
         MembersRoute.name,
         args: MembersRouteArgs(key: key, spaceID: spaceID),
         initialChildren: children,
       );

  static const String name = 'MembersRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MembersRouteArgs>();
      return _i12.MembersScreen(key: args.key, spaceID: args.spaceID);
    },
  );
}

class MembersRouteArgs {
  const MembersRouteArgs({this.key, required this.spaceID});

  final _i23.Key? key;

  final String spaceID;

  @override
  String toString() {
    return 'MembersRouteArgs{key: $key, spaceID: $spaceID}';
  }
}

/// generated route for
/// [_i13.MyTaskScreen]
class MyTaskRoute extends _i22.PageRouteInfo<void> {
  const MyTaskRoute({List<_i22.PageRouteInfo>? children})
    : super(MyTaskRoute.name, initialChildren: children);

  static const String name = 'MyTaskRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i13.MyTaskScreen();
    },
  );
}

/// generated route for
/// [_i14.OnboardingScreen]
class OnboardingRoute extends _i22.PageRouteInfo<void> {
  const OnboardingRoute({List<_i22.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i14.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i15.ProfileScreen]
class ProfileRoute extends _i22.PageRouteInfo<void> {
  const ProfileRoute({List<_i22.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i15.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i16.RootNavigatorScreen]
class RootNavigatorRoute extends _i22.PageRouteInfo<void> {
  const RootNavigatorRoute({List<_i22.PageRouteInfo>? children})
    : super(RootNavigatorRoute.name, initialChildren: children);

  static const String name = 'RootNavigatorRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i16.RootNavigatorScreen();
    },
  );
}

/// generated route for
/// [_i17.SignUpScreen]
class SignUpRoute extends _i22.PageRouteInfo<void> {
  const SignUpRoute({List<_i22.PageRouteInfo>? children})
    : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i17.SignUpScreen();
    },
  );
}

/// generated route for
/// [_i18.SpaceDetailsScreen]
class SpaceDetailsRoute extends _i22.PageRouteInfo<SpaceDetailsRouteArgs> {
  SpaceDetailsRoute({
    _i23.Key? key,
    required String spaceID,
    List<_i22.PageRouteInfo>? children,
  }) : super(
         SpaceDetailsRoute.name,
         args: SpaceDetailsRouteArgs(key: key, spaceID: spaceID),
         initialChildren: children,
       );

  static const String name = 'SpaceDetailsRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SpaceDetailsRouteArgs>();
      return _i18.SpaceDetailsScreen(key: args.key, spaceID: args.spaceID);
    },
  );
}

class SpaceDetailsRouteArgs {
  const SpaceDetailsRouteArgs({this.key, required this.spaceID});

  final _i23.Key? key;

  final String spaceID;

  @override
  String toString() {
    return 'SpaceDetailsRouteArgs{key: $key, spaceID: $spaceID}';
  }
}

/// generated route for
/// [_i19.SpacesScreen]
class SpacesRoute extends _i22.PageRouteInfo<void> {
  const SpacesRoute({List<_i22.PageRouteInfo>? children})
    : super(SpacesRoute.name, initialChildren: children);

  static const String name = 'SpacesRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i19.SpacesScreen();
    },
  );
}

/// generated route for
/// [_i20.SplashScreen]
class SplashRoute extends _i22.PageRouteInfo<void> {
  const SplashRoute({List<_i22.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i20.SplashScreen();
    },
  );
}

/// generated route for
/// [_i21.VideoPlayerScreen]
class VideoPlayerRoute extends _i22.PageRouteInfo<VideoPlayerRouteArgs> {
  VideoPlayerRoute({
    _i23.Key? key,
    required String videoId,
    List<_i22.PageRouteInfo>? children,
  }) : super(
         VideoPlayerRoute.name,
         args: VideoPlayerRouteArgs(key: key, videoId: videoId),
         initialChildren: children,
       );

  static const String name = 'VideoPlayerRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VideoPlayerRouteArgs>();
      return _i21.VideoPlayerScreen(key: args.key, videoId: args.videoId);
    },
  );
}

class VideoPlayerRouteArgs {
  const VideoPlayerRouteArgs({this.key, required this.videoId});

  final _i23.Key? key;

  final String videoId;

  @override
  String toString() {
    return 'VideoPlayerRouteArgs{key: $key, videoId: $videoId}';
  }
}
