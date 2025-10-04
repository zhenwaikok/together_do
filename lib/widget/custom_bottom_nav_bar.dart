import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mpma_assignment/constant/color_manager.dart';
import 'package:mpma_assignment/constant/font_manager.dart';
import 'package:mpma_assignment/router/router.gr.dart';

@RoutePage()
class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      physics: NeverScrollableScrollPhysics(),
      routes: getRoutes(),
      builder: (context, child, _) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: child,
          bottomNavigationBar: SafeArea(
            bottom: false,
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                boxShadow: [getTabBarShadow()],
              ),
              child: BottomNavigationBar(
                backgroundColor: ColorManager.whiteColor,
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: ColorManager.blackColor.withValues(
                  alpha: 0.5,
                ),
                selectedItemColor: ColorManager.primary,
                selectedLabelStyle: _Styles.selectedItemLabelStyle,
                unselectedLabelStyle: _Styles.unselectedItemLabelStyle,
                showUnselectedLabels: true,
                currentIndex: tabsRouter.activeIndex,
                onTap: (index) =>
                    onItemTapped(index: index, tabsRouter: tabsRouter),
                items: getBottomNavBarItems(),
              ),
            ),
          ),
        );
      },
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _CustomBottomNavBarState {
  void onItemTapped({required int index, required TabsRouter tabsRouter}) {
    tabsRouter.setActiveIndex(index);
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CustomBottomNavBarState {
  BoxShadow getTabBarShadow() {
    return BoxShadow(
      color: ColorManager.greyColor.withValues(alpha: 0.1),
      blurRadius: 6,
      offset: const Offset(0, -1),
    );
  }

  List<PageRouteInfo> getRoutes() {
    return [
      HomeRoute(),
      SpacesRoute(),
      HomeTipsRoute(),
      MyTaskRoute(),
      ProfileRoute(),
    ];
  }

  List<BottomNavigationBarItem> getBottomNavBarItems() {
    return [
      getBottomNavBarIcon(icon: Icons.home, label: 'Home'),
      getBottomNavBarIcon(icon: Icons.groups_rounded, label: 'Spaces'),
      getBottomNavBarIcon(icon: Icons.newspaper, label: 'Tips'),
      getBottomNavBarIcon(icon: Icons.task, label: 'My Tasks'),
      getBottomNavBarIcon(icon: Icons.person, label: 'Profile'),
    ];
  }

  BottomNavigationBarItem getBottomNavBarIcon({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon, size: _Styles.bottomNavBarIconSize),
      label: label,
    );
  }
}

// * ----------------------------- Styles -----------------------------
class _Styles {
  _Styles._();

  static const bottomNavBarIconSize = 28.0;

  static const selectedItemLabelStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeightManager.bold,
  );

  static const unselectedItemLabelStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeightManager.regular,
  );
}
