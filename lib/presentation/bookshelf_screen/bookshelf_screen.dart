import 'package:flutter/material.dart';

import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_decoration.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';


class BookshelfScreen extends StatelessWidget {
  BookshelfScreen({Key? key})
      : super(
    key: key,
  );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 19.h,
            vertical: 23.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 9.v),
              Padding(
                padding: EdgeInsets.only(left: 6.h),
                child: Text(
                  "Kệ sách",
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              SizedBox(height: 9.v),
              Container(
                margin: EdgeInsets.only(left: 1.h),
                padding: EdgeInsets.symmetric(
                  horizontal: 14.h,
                  vertical: 17.v,
                ),
                decoration: AppDecoration.fillOnPrimaryContainer,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 267.v),
                      child: Column(
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgRectangle24,
                            height: 121.v,
                            width: 92.h,
                          ),
                          SizedBox(height: 4.v),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Âm nhạc",
                              style: theme.textTheme.labelLarge,
                            ),
                          ),
                          SizedBox(height: 10.v),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 121.v,
                                width: 92.h,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 22.h,
                                  vertical: 36.v,
                                ),
                                decoration: AppDecoration.fillGray400,
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgPlus,
                                  height: 48.adaptSize,
                                  width: 48.adaptSize,
                                  alignment: Alignment.center,
                                ),
                              ),
                              SizedBox(height: 4.v),
                              Text(
                                "Tạo mới",
                                style: theme.textTheme.labelLarge,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 16.h,
                        bottom: 421.v,
                      ),
                      child: _buildComponentTwentyOne(context),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10.h,
                        bottom: 421.v,
                      ),
                      child: _buildComponentTwentyOne(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
          bottomNavigationBar: _buildHome(context)
      ),
    );
  }


  /// Common widget
  Widget _buildComponentTwentyOne(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgRectangle25121x92,
          height: 121.v,
          width: 92.h,
        ),
        SizedBox(height: 5.v),
        Text(
          "Khoa học",
          style: theme.textTheme.labelLarge,
        ),
      ],
    );
  }
  Widget _buildHome(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 26.h, right: 31.h, bottom: 38.v),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              onTapHomeComponent(context);
            },
            child: Padding(
              padding: EdgeInsets.only(top: 2.v),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgHomeErrorcontainer,
                    height: 20.v,
                    width: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6.v),
                    child: Text(
                      "Trang chủ",
                      style: CustomTextStyles.bodyMediumPoppinsLight_1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(flex: 45),
          GestureDetector(
            onTap: () {
              onTapHistoryComponent(context);
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 2.v),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgClock,
                    height: 20.adaptSize,
                    width: 20.adaptSize,
                  ),
                  Text(
                    "Lịch sử",
                    style: CustomTextStyles.bodyMediumPoppinsLight_1,
                  ),
                ],
              ),
            ),
          ),
          Spacer(flex: 54),
          GestureDetector(
            onTap: () {
              onTapBookshelfComponent(context);
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 2.v),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgBook2Blue300,
                    height: 20.adaptSize,
                    width: 20.adaptSize,
                    margin: EdgeInsets.only(left: 13.h),
                  ),
                  Text(
                    "Kệ sách",
                    style: CustomTextStyles.bodyMediumPoppinsBlue300,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  /// Navigates to the continuedBookScreen when the action is triggered.
  onTapContinuedButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.continuedBookScreen);
  }

  /// Navigates to the homeScreen when the action is triggered.
  onTapHomeComponent(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homeScreen);
  }

  /// Navigates to the bookshelfContainerScreen when the action is triggered.
  onTapBookshelfComponent(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.bookshelfScreen);
  }
  onTapHistoryComponent(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.historyScreen);
  }
}