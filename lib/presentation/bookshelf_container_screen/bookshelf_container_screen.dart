import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/presentation/bookshelf_page/bookshelf_page.dart';
import 'package:rbooks/presentation/history_screen/history_screen.dart';
import 'package:rbooks/presentation/home_screen/home_screen.dart';
import 'package:rbooks/widgets/custom_bottom_bar.dart';

// ignore_for_file: must_be_immutable
class BookshelfContainerScreen extends StatelessWidget {
  BookshelfContainerScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: Navigator(
                key: navigatorKey,
                initialRoute: AppRoutes.bookshelfPage,
                onGenerateRoute: (routeSetting) => PageRouteBuilder(
                    pageBuilder: (ctx, ani, ani1) =>
                        getCurrentPage(routeSetting.name!),
                    transitionDuration: Duration(seconds: 0))),
            bottomNavigationBar: Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.h),
                child: _buildBottomBar(context))));
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Trangch:
        return AppRoutes.homeScreen;
      case BottomBarEnum.Lchs:
        return AppRoutes.historyScreen;
      case BottomBarEnum.Ksch:
        return AppRoutes.bookshelfContainerScreen;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.bookshelfPage:
        return BookshelfPage();
      case AppRoutes.homeScreen:
        return HomeScreen();
      case AppRoutes.historyScreen:
        return HistoryScreen();
      default:
        return DefaultWidget();
    }
  }
}
