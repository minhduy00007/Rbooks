import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/widgets/app_bar/appbar_leading_image.dart';
import 'package:rbooks/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:rbooks/widgets/app_bar/appbar_title_circleimage.dart';
import 'package:rbooks/widgets/app_bar/custom_app_bar.dart';
import 'package:rbooks/widgets/custom_text_form_field.dart';

import '../../widgets/app_bar/appbar_leading_circleimage.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable
class AccountAdminConnectScreen extends StatelessWidget {
  AccountAdminConnectScreen({Key? key}) : super(key: key);

  TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 7.h, vertical: 35.v),
                child: Column(children: [
                  _buildComponentSeventeen(context),
                  Spacer(),
                  SizedBox(height: 6.v),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    CustomElevatedButton(width: 85.h, text: "Xác nhận"),
                    CustomElevatedButton(
                        width: 85.h,
                        text: "Hủy",
                        margin: EdgeInsets.only(left: 61.h),
                        buttonStyle: CustomButtonStyles.fillRedA,
                        onPressed: () {
                          onTapTxtHY(context);
                        })
                  ])
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 44.v,
        leadingWidth: 37.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeftOnprimary,
            margin: EdgeInsets.only(left: 13.h, top: 10.v, bottom: 10.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        centerTitle: true,
        title: AppbarSubtitle(text: "Quyền admin"));
  }

  Widget _buildComponentSeventeen(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 7.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 9.v),
            child: Text("Mã admin:", style: theme.textTheme.titleSmall),
          ),
          SizedBox(width: 16.h),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.h),
              child: CustomTextFormField(
                controller: inputController,
                hintText: "Nhập mã",
                textInputType: TextInputType.emailAddress,
                width: 220,)),
        ],
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homeScreen);
  }

  /// Navigates to the informationOneScreen when the action is triggered.
  onTapThirtyFive(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.informationOneScreen);
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapThirtySix(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }

  /// Navigates to the accountScreen when the action is triggered.
  onTapTxtXCNhN(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.adminHomeScreen);
  }

  /// Navigates to the accountScreen when the action is triggered.
  onTapTxtHY(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.accountScreen);
  }

  /// Navigates to the requestAndReportScreen when the action is triggered.
  onTapThirtyTwo(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.requestAndReportScreen);
  }
}
