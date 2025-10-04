import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/utils/mixins/error_handling_mixin.dart';

abstract class BaseStatefulPage extends StatefulWidget {
  const BaseStatefulPage({super.key});
}

/// A basic state that include common widgets and Ui logic handling
abstract class BaseStatefulState<Page extends BaseStatefulPage>
    extends State<Page>
    with ErrorHandlingMixin {
  /// Basic component helper
  PreferredSizeWidget? appbar() => null;

  Widget body();

  Widget? floatingActionButton() => null;

  Color backgroundColor() => ColorManager.whiteColor;

  EdgeInsets defaultPadding() => const EdgeInsets.all(20.0);

  EdgeInsets bottomNavigationBarPadding() => const EdgeInsets.all(20.0);

  bool topSafeAreaEnabled() => false;

  bool bottomSafeAreaEnabled() => true;

  Widget? bottomNavigationBar() => null;

  /// Each Page are meant to be build with a [Scaffold] structure
  /// include with [AppBar], [Body], [FloatingActionButton]
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: appbar(),
      bottomNavigationBar: Padding(
        padding: bottomNavigationBarPadding(),
        child: bottomNavigationBar(),
      ),
      body: SafeArea(
        left: false,
        right: false,
        top: topSafeAreaEnabled(),
        bottom: bottomSafeAreaEnabled(),
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(padding: defaultPadding(), child: body()),
        ),
      ),
      floatingActionButton: floatingActionButton(),
    );
  }
}
