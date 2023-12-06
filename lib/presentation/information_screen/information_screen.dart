import '../information_screen/widgets/information_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/widgets/app_bar/appbar_leading_image.dart';
import 'package:rbooks/widgets/app_bar/appbar_title.dart';
import 'package:rbooks/widgets/app_bar/custom_app_bar.dart';
import 'package:rbooks/widgets/custom_elevated_button.dart';
import 'package:rbooks/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class InformationScreen extends StatelessWidget {
  InformationScreen({Key? key}) : super(key: key);

  TextEditingController tnbsuutpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 26.v),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.only(left: 5.h, right: 11.h),
                      child: CustomTextFormField(
                          controller: tnbsuutpController,
                          hintText: "Tên bộ suu tập",
                          hintStyle: CustomTextStyles.bodySmallInter,
                          textInputAction: TextInputAction.done)),
                  SizedBox(height: 31.v),
                  _buildInformation(context)
                ])),
            bottomNavigationBar: _buildThm(context)));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 47.v,
        leadingWidth: 53.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.only(left: 29.h, top: 5.v, bottom: 18.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        title: AppbarTitle(
            text: "Tạo bộ sưu tập", margin: EdgeInsets.only(left: 27.h)));
  }

  /// Section Widget
  Widget _buildInformation(BuildContext context) {
    return Expanded(
        child: SizedBox(
            height: 142.v,
            child: ListView.separated(
                padding: EdgeInsets.only(right: 1.h),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return SizedBox(width: 15.h);
                },
                itemCount: 4,
                itemBuilder: (context, index) {
                  return InformationItemWidget();
                })));
  }

  /// Section Widget
  Widget _buildThm(BuildContext context) {
    return CustomElevatedButton(
        height: 37.v,
        width: 212.h,
        text: "Thêm",
        margin: EdgeInsets.only(left: 80.h, right: 83.h, bottom: 53.v),
        buttonStyle: CustomButtonStyles.fillPrimary,
        buttonTextStyle: CustomTextStyles.titleSmallInter,
        onPressed: () {
          onTapThm(context);
        });
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the bookshelfContainerScreen when the action is triggered.
  onTapThm(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.bookshelfContainerScreen);
  }
}
