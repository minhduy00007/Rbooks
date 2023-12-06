import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/widgets/app_bar/appbar_leading_image.dart';
import 'package:rbooks/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:rbooks/widgets/app_bar/appbar_title_circleimage.dart';
import 'package:rbooks/widgets/app_bar/custom_app_bar.dart';

import '../../widgets/app_bar/appbar_leading_circleimage.dart';
import '../../widgets/app_bar/appbar_title_edittext.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isAdmin = false;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    // Gọi hàm kiểm tra quyền admin khi widget được build
    checkAdminPermission(context);

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 27.h, vertical: 28.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5.h),
                child: Text(
                  "Thông tin tài khoản",
                  style: CustomTextStyles.titleMediumCyan400,
                ),
              ),
              SizedBox(height: 17.v),
              _buildThirtyEight(context),
              SizedBox(height: 24.v),
              Padding(
                padding: EdgeInsets.only(left: 5.h),
                child: Text(
                  "Quản lý tài khoản",
                  style: CustomTextStyles.titleMediumPrimary,
                ),
              ),
              SizedBox(height: 18.v),
              _buildThirtyNine(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 90.v,
      title: Padding(
        padding: EdgeInsets.only(left: 44.h),
        child: Row(
          children: [
            AppbarLeadingImage(
              imagePath: ImageConstant.imgArrowLeft,
              margin: EdgeInsets.only(left: 9.h),
              onTap: () {
                onTapArrowLeft(context);
              },
            ),
            AppbarLeadingCircleimage(
              imagePath: ImageConstant.imgEllipse5,
              margin: EdgeInsets.only(left: 17.h, top: 1.v, bottom: 1.v),
            ),
            AppbarSubtitleOne(
              text: "Kiệt Bùi",
              margin: EdgeInsets.only(left: 26.h, top: 26.v, bottom: 28.v),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildThirtyEight(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapThirtyEight(context);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 5.h, right: 16.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Thay đổi thông tin", style: theme.textTheme.titleMedium),
            CustomImageView(
              imagePath: ImageConstant.imgArrowRight,
              height: 12.v,
              width: 6.h,
              margin: EdgeInsets.only(top: 6.v, bottom: 8.v),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildThirtyNine(BuildContext context) {
    // Ở đây kiểm tra giá trị của biến isAdmin để quyết định hiển thị widget
    if (isAdmin) {
      return GestureDetector(
        onTap: () {
          onTapThirtyNine(context);
        },
        child: Padding(
          padding: EdgeInsets.only(left: 2.h, right: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Quyền Admin", style: theme.textTheme.titleMedium),
              CustomImageView(
                imagePath: ImageConstant.imgArrowRight,
                height: 12.v,
                width: 6.h,
                margin: EdgeInsets.only(top: 6.v, bottom: 8.v),
              ),
            ],
          ),
        ),
      );
    } else {
      // Nếu không có quyền admin, có thể trả về một widget khác hoặc null
      return SizedBox.shrink();
    }
  }

  /// Section Widget

  void checkAdminPermission(BuildContext context) async {
    try {
      // Lấy thông tin người dùng hiện tại
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Lấy dữ liệu người dùng từ Firestore
        DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        // Kiểm tra giá trị của trường quyen_admin
        bool isAdmin = userDoc.get('quyen_admin');

        // Nếu là quyền admin, thì thực hiện hiển thị quyền admin
        if (isAdmin) {
          print('Người dùng có quyền admin');
          // Cập nhật giá trị của biến isAdmin trong State để sử dụng trong Widget build
          setState(() {
            this.isAdmin = true;
          });
        } else {
          print('Người dùng không có quyền admin');
          setState(() {
            this.isAdmin = false;
          });
        }
      }
    } catch (error) {
      print('Lỗi khi kiểm tra quyền admin: $error');
    }
  }

  // Gọi hàm kiểm tra quyền admin trong Widget build hoặc trong một hàm khác
  void someFunction() {
    checkAdminPermission(context);
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.menu);
  }

  /// Navigates to the informationOneScreen when the action is triggered.
  onTapThirtyEight(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.informationOneScreen);
  }

  /// Navigates to the accountAdminConnectScreen when the action is triggered.
  onTapThirtyNine(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.adminHomeScreen);
  }

  /// Navigates to the requestAndReportScreen when the action is triggered.
  onTapForty(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.requestAndReportScreen);
  }
}
