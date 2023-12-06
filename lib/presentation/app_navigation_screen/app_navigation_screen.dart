import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';

class AppNavigationScreen extends StatelessWidget {
  const AppNavigationScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFFFFFFF),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildAppNavigation(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0XFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        _buildScreenTitle(
                          context,
                          screenTitle: "Book\\'s Chapter update",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.bookSChapterUpdateScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Login",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.loginScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Register",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.registerScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Forget Password",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.forgetPasswordScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Home",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.homeScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Book - Tab Container",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.bookTabContainerScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "ReadBook",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.readbookScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "ReadBook Next",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.readbookNextScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "History",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.historyScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Continued Book Previous",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.continuedBookPreviousScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Continued Book",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.continuedBookScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Continued Book Next",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.continuedBookNextScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Bookshelf - Container",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.bookshelfContainerScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Information",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.informationScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Search",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.searchScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Category",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.categoryScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Like",
                          onTapScreenTitle: () =>
                              onTapScreenTitle(context, AppRoutes.likeScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Account",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.accountScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Information One",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.informationOneScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Request and Report",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.requestAndReportScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Account Admin Connect",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.accountAdminConnectScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Admin Home",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.adminHomeScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "BookUpdate",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.bookupdateScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Book Add",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.bookAddScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Book\\'s Chapter ",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.bookSChapterScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Book\\'s Chapter Add",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.bookSChapterAddScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Category Admin",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.categoryAdminScreen),
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Category Add",
                          onTapScreenTitle: () => onTapScreenTitle(
                              context, AppRoutes.categoryAddScreen),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAppNavigation(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFFFFFFF),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                "App Navigation",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF000000),
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.h),
              child: Text(
                "Check your app's UI from the below demo screens of your app.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF888888),
                  fontSize: 16.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.v),
          Divider(
            height: 1.v,
            thickness: 1.v,
            color: Color(0XFF000000),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildScreenTitle(
    BuildContext context, {
    required String screenTitle,
    Function? onTapScreenTitle,
  }) {
    return GestureDetector(
      onTap: () {
        onTapScreenTitle!.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0XFFFFFFFF),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.v),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Text(
                  screenTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0XFF000000),
                    fontSize: 20.fSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.v),
            SizedBox(height: 5.v),
            Divider(
              height: 1.v,
              thickness: 1.v,
              color: Color(0XFF888888),
            ),
          ],
        ),
      ),
    );
  }

  /// Common click event
  void onTapScreenTitle(
    BuildContext context,
    String routeName,
  ) {
    Navigator.pushNamed(context, routeName);
  }
}
