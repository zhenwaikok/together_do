import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/constant.dart';
import 'package:mpma_assignment/router/router.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: providerAssets(), child: AppWrapper());
  }
}

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  final _router = AppRouter();

  @override
  void initState() {
    super.initState();
    setupEasyLoading();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router.config(),
      builder: (context, child) {
        final easyLoadingInitializer = EasyLoading.init(
          builder: (context, child) {
            final mediaQueryData = MediaQuery.of(context);
            final scale = mediaQueryData.textScaler;
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: scale),
              child: child ?? SizedBox(),
            );
          },
        );
        return easyLoadingInitializer(context, child);
      },
      theme: ThemeData(scaffoldBackgroundColor: ColorManager.whiteColor),
    );
  }
}

extension on _AppWrapperState {
  void setupEasyLoading() {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.ring;
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
  }
}
