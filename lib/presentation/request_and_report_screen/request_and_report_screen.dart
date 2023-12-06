import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/widgets/app_bar/appbar_leading_image.dart';
import 'package:rbooks/widgets/app_bar/appbar_title.dart';
import 'package:rbooks/widgets/app_bar/appbar_trailing_image.dart';
import 'package:rbooks/widgets/app_bar/custom_app_bar.dart';
import 'package:rbooks/widgets/custom_elevated_button.dart';
import 'package:rbooks/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class RequestAndReportScreen extends StatelessWidget {
  RequestAndReportScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  TextEditingController nidungphnhiController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding:
                        EdgeInsets.symmetric(horizontal: 55.h, vertical: 59.v),
                    child: Column(children: [
                      Padding(
                          padding: EdgeInsets.only(left: 5.h, right: 67.h),
                          child: CustomTextFormField(
                              controller: emailController,
                              hintText: "Email",
                              hintStyle: CustomTextStyles.bodySmallInter,
                              textInputType: TextInputType.emailAddress,
                              alignment: Alignment.centerLeft,
                              borderDecoration:
                                  TextFormFieldStyleHelper.fillGray,
                              fillColor: appTheme.gray40001)),
                      SizedBox(height: 11.v),
                      CustomTextFormField(
                          controller: nidungphnhiController,
                          hintText: "Nội dung phản hồi",
                          hintStyle: CustomTextStyles.bodySmallInter,
                          textInputAction: TextInputAction.done,
                          maxLines: 8,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 13.h, vertical: 17.v),
                          borderDecoration: TextFormFieldStyleHelper.fillGray,
                          fillColor: appTheme.gray40001),
                      SizedBox(height: 12.v),
                      CustomElevatedButton(
                          height: 37.v,
                          text: "GỬI PHẢN HỒI",
                          margin: EdgeInsets.only(left: 34.h, right: 38.h),
                          buttonStyle: CustomButtonStyles.fillGreen,
                          buttonTextStyle: CustomTextStyles.bodySmallInter,
                          onPressed: () {
                            onTapGIPHNHI(context);
                          }),
                      SizedBox(height: 5.v)
                    ])))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 35.v,  // Tăng giá trị này thêm 20.v
      leadingWidth: 58.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeftErrorcontainer10x24,
        margin: EdgeInsets.only(left: 34.h, bottom: 5.v),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(text: "Yêu cầu và báo lỗi "),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgGroup31,
          margin: EdgeInsets.only(left: 9.h, right: 54.h, bottom: 5.v),
        ),
      ],
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.menu);
  }

  /// Navigates to the accountScreen when the action is triggered.
  onTapGIPHNHI(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.accountScreen);
  }
}
