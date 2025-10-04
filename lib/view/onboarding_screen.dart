import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mpma_assignment/base_stateful_page.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/constant.dart';
import 'package:mpma_assignment/constant/font_manager.dart';
import 'package:mpma_assignment/constant/styles_manager.dart';
import 'package:mpma_assignment/router/router.gr.dart';
import 'package:mpma_assignment/utils/shared_preference_handler.dart';
import 'package:mpma_assignment/widget/custom_button.dart';
import 'package:mpma_assignment/widget/dot_indicator.dart';

class OnBoard {
  final String image, title, description;

  OnBoard({
    required this.image,
    required this.title,
    required this.description,
  });
}

@RoutePage()
class OnboardingScreen extends BaseStatefulPage {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends BaseStatefulState<OnboardingScreen> {
  final onboardData = OnboardData.onboardData;

  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return StylesManager.zeroPadding;
  }

  @override
  Widget body() {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            itemCount: onboardData.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            controller: _pageController,
            itemBuilder: (context, index) => getOnboardContent(
              image: onboardData[index].image,
              title: onboardData[index].title,
              description: onboardData[index].description,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getDotIndicator(),
            currentIndex == onboardData.length - 1
                ? getBottomStarButton()
                : getBottomNextButton(),
          ],
        ),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _OnboardingScreenState {
  void onNextButtonPressed() {
    _pageController.nextPage(
      duration: Duration(milliseconds: _Styles.animatedDuration),
      curve: Curves.ease,
    );
  }

  void onStartButtonPressed() {
    SharedPreferenceHandler().putHasOnboarded(true);
    context.router.replaceAll([LoginRoute()]);
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _OnboardingScreenState {
  Widget getOnboardContent({
    required String image,
    required String title,
    required String description,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getOnboardImage(image: image),
        SizedBox(height: 12),
        getOnboardMessage(title: title, description: description),
      ],
    );
  }

  Widget getOnboardImage({required String image}) {
    return Image.asset(
      image,
      width: _Styles.onboardImageSize,
      height: _Styles.onboardImageSize,
    );
  }

  Widget getOnboardMessage({
    required String title,
    required String description,
  }) {
    return Column(
      children: [
        Text(title, style: _Styles.titleTextStyle, textAlign: TextAlign.center),

        SizedBox(height: 12),

        Text(
          description,
          style: _Styles.descriptionTextStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget getBottomNextButton() {
    return SizedBox(
      height: _Styles.bottomNextButtonSize,
      child: ElevatedButton(
        onPressed: () {
          onNextButtonPressed();
        },
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: ColorManager.primary,
        ),
        child: Icon(
          Icons.arrow_forward_rounded,
          color: ColorManager.whiteColor,
          size: _Styles.iconSize,
        ),
      ),
    );
  }

  Widget getBottomStarButton() {
    return SizedBox(
      height: _Styles.bottomStartButtonHeight,
      width: _Styles.bottomStartButtonWidth,
      child: CustomButton(
        text: 'Get Started',
        textColor: ColorManager.whiteColor,
        onPressed: onStartButtonPressed,
      ),
    );
  }

  Widget getDotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
        onboardData.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: _Styles.indicatorRightPadding),
          child: DotIndicator(isActive: index == currentIndex),
        ),
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const onboardImageSize = 350.0;
  static const bottomNextButtonSize = 60.0;
  static const bottomStartButtonHeight = 40.0;
  static const bottomStartButtonWidth = 150.0;
  static const iconSize = 25.0;
  static const animatedDuration = 300;
  static const indicatorRightPadding = 8.0;

  static const titleTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeightManager.bold,
    color: ColorManager.blackColor,
  );

  static const descriptionTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeightManager.regular,
    color: ColorManager.blackColor,
  );
}
