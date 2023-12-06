import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';

class BookshelfPage extends StatelessWidget {
  const BookshelfPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.maxFinite,
                decoration: AppDecoration.fillGray,
                child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 19.h, vertical: 23.v),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 9.v),
                          Padding(
                              padding: EdgeInsets.only(left: 6.h),
                              child: Text("Kệ sách",
                                  style: CustomTextStyles
                                      .headlineSmallPoppinsBold)),
                          SizedBox(height: 9.v),
                          Container(
                              margin: EdgeInsets.only(left: 1.h),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 14.h, vertical: 17.v),
                              decoration: AppDecoration.fillOnPrimaryContainer,
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 267.v),
                                        child: Column(children: [
                                          CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgRectangle24,
                                              height: 121.v,
                                              width: 92.h),
                                          SizedBox(height: 4.v),
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("Âm nhạc",
                                                  style: theme
                                                      .textTheme.labelLarge)),
                                          SizedBox(height: 10.v),
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    height: 121.v,
                                                    width: 92.h,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 22.h,
                                                            vertical: 36.v),
                                                    decoration: AppDecoration
                                                        .fillGray400,
                                                    child: CustomImageView(
                                                        imagePath: ImageConstant
                                                            .imgPlus,
                                                        height: 48.adaptSize,
                                                        width: 48.adaptSize,
                                                        alignment:
                                                            Alignment.center,
                                                        onTap: () {
                                                          onTapImgPlus(context);
                                                        })),
                                                SizedBox(height: 4.v),
                                                Text("Tạo mới",
                                                    style: theme
                                                        .textTheme.labelLarge)
                                              ])
                                        ])),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 16.h, bottom: 421.v),
                                        child:
                                            _buildComponentTwentyOne(context)),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.h, bottom: 421.v),
                                        child:
                                            _buildComponentTwentyOne(context))
                                  ]))
                        ])))));
  }

  /// Common widget
  Widget _buildComponentTwentyOne(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CustomImageView(
          imagePath: ImageConstant.imgRectangle25121x92,
          height: 121.v,
          width: 92.h),
      SizedBox(height: 5.v),
      Text("Khoa học", style: theme.textTheme.labelLarge)
    ]);
  }

  /// Navigates to the informationScreen when the action is triggered.
  onTapImgPlus(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.informationScreen);
  }
}
