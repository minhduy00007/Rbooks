import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/widgets/custom_elevated_button.dart';
import 'package:rbooks/widgets/custom_text_form_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 10.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(flex: 21),
                Padding(
                  padding: EdgeInsets.only(left: 63.h),
                  child: Text(
                    "Quên mật khẩu",
                    style: CustomTextStyles.headlineSmallPoppinsBold,
                  ),
                ),
                SizedBox(height: 73.v),
                Padding(
                  padding: EdgeInsets.only(right: 14.h),
                  child: CustomTextFormField(
                    controller: emailController,
                    hintText: "Nhập email",
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.emailAddress,
                  ),
                ),
                Spacer(flex: 37),
                CustomElevatedButton(
                  height: 52.v,
                  width: 226.h,
                  text: "Gửi",
                  buttonStyle: CustomButtonStyles.fillOrange,
                  buttonTextStyle: CustomTextStyles.titleMediumOnPrimaryContainer,
                  onPressed: () {
                    guiEmailDatLaiMatKhau(context);
                  },
                  alignment: Alignment.center,
                ),
                Spacer(flex: 41),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(width: 120.h, child: Divider()),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Gửi email đặt lại mật khẩu đến địa chỉ email đã nhập.
  void guiEmailDatLaiMatKhau(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      // Email đặt lại mật khẩu đã được gửi thành công
      // Hiển thị thông báo cho người dùng, ví dụ: Toast, SnackBar, Dialog, ...
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email đặt lại mật khẩu đã được gửi thành công'),
        ),
      );

      // Quay trở lại trang đăng nhập sau khi gửi email thành công
      Navigator.pushNamed(context, AppRoutes.loginScreen);
    } catch (error) {
      // Xử lý lỗi, nếu có
      // Hiển thị thông báo lỗi cho người dùng
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lỗi khi gửi email đặt lại mật khẩu: $error'),
        ),
      );
    }
  }
}