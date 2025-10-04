import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mpma_assignment/base_stateful_page.dart';
import 'package:mpma_assignment/constant/images.dart';

@RoutePage()
class SplashScreen extends BaseStatefulPage {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseStatefulState<SplashScreen> {
  @override
  bool topSafeAreaEnabled() => false;

  @override
  Widget body() {
    return Center(
      child: Image.asset(
        Images.appLogo,
        width: 200,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }
}
