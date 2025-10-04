import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mpma_assignment/router/router.gr.dart';
import 'package:mpma_assignment/utils/shared_preference_handler.dart';
import 'package:mpma_assignment/viewmodel/user_view_model.dart';
import 'package:provider/provider.dart';

@RoutePage()
class RootNavigatorScreen extends StatefulWidget {
  const RootNavigatorScreen({super.key});

  @override
  State<RootNavigatorScreen> createState() => _RootNavigatorScreenState();
}

class _RootNavigatorScreenState extends State<RootNavigatorScreen> {
  late final UserViewModel _userVM;
  bool _isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();

    _userVM = context.read<UserViewModel>();

    _isUserLoggedIn = _userVM.isLoggedIn;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _navigateBasedOnState();
    });

    // Listen to login state changes using ChangeNotifier
    _userVM.addListener(_onUserVMChanged);
  }

  @override
  void dispose() {
    _userVM.removeListener(_onUserVMChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AutoRouter();
  }

  Future<void> _navigateBasedOnState() async {
    final hasOnboarded = SharedPreferenceHandler().getHasOnboarded() ?? false;
    print('user: ${_userVM.user}');
    if (hasOnboarded) {
      if (_isUserLoggedIn) {
        print('is log in');
        await context.router.replaceAll([CustomBottomNavBar()]);
      } else {
        print('is not log in');
        await context.router.replaceAll([LoginRoute()]);
      }
    } else {
      print('is onbaord');
      await context.router.replaceAll([OnboardingRoute()]);
    }
  }

  void _onUserVMChanged() {
    if (mounted && _isUserLoggedIn != _userVM.isLoggedIn) {
      _isUserLoggedIn = _userVM.isLoggedIn;
      // Since we're in a listener, we might need to schedule the navigation after the current frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigateBasedOnState();
      });
    }
  }
}
