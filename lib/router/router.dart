import 'package:auto_route/auto_route.dart';
import 'package:mpma_assignment/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: RootNavigatorRoute.page,
      initial: true,
      children: [...getAppEntryRoutes(), ...getDashboardRoutes()],
    ),
  ];

  List<AutoRoute> getAppEntryRoutes() {
    return [
      AutoRoute(page: OnboardingRoute.page),
      AutoRoute(page: LoginRoute.page),
      AutoRoute(page: SignUpRoute.page),
      AutoRoute(page: ForgotPasswordRoute.page),
    ];
  }

  List<AutoRoute> getDashboardRoutes() {
    return [
      AutoRoute(
        page: CustomBottomNavBar.page,
        children: [
          AutoRoute(page: HomeRoute.page),
          AutoRoute(page: SpacesRoute.page),
          AutoRoute(page: HomeTipsRoute.page),
          AutoRoute(page: MyTaskRoute.page),
          AutoRoute(page: ProfileRoute.page),
        ],
      ),
      AutoRoute(page: CreateEditSpaceRoute.page),
      AutoRoute(page: SpaceDetailsRoute.page),
      AutoRoute(page: VideoPlayerRoute.page),
      AutoRoute(page: CreateEditChoreRoute.page),
      AutoRoute(page: MembersRoute.page),
      AutoRoute(page: ChoresBySpaceRoute.page),
      AutoRoute(page: ChangePasswordRoute.page),
      AutoRoute(page: EditProfileRoute.page),
      AutoRoute(page: ChoreDetailsRoute.page),
    ];
  }
}
