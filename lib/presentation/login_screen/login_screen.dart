import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/widgets/custom_elevated_button.dart';
import 'package:rbooks/widgets/custom_text_form_field.dart';

import '../forget_password_screen/forget_password_screen.dart';
import '../register_screen/register_screen.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  TextEditingController inputController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 42.v),
                          Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                  padding: EdgeInsets.only(right: 42.h),
                                  child: Text("Chào mừng trở lại!",
                                      style: CustomTextStyles
                                          .headlineSmallPoppinsBold))),
                          SizedBox(height: 10.v),
                          CustomImageView(
                              imagePath: ImageConstant.imgUndrawLoginRe4vu2,
                              height: 200.v,
                              width: 335.h),
                          SizedBox(height: 33.v),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.h),
                              child: CustomTextFormField(
                                  controller: emailController,
                                  hintText: "Nhập email",
                                  textInputType: TextInputType.emailAddress)),
                          SizedBox(height: 17.v),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.h),
                              child: CustomTextFormField(
                                  controller: inputController,
                                  hintText: "Nhập mật khẩu",
                                  textInputType: TextInputType.visiblePassword,
                                obscureText: true,)),
                          SizedBox(height: 60.v),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForgetPasswordScreen(),
                                  ),
                                );
                              },
                              child: Text("Quên mật khẩu",
                                  style: CustomTextStyles.labelLargeOnError)),
                          SizedBox(height: 16.v),
                          CustomElevatedButton(
                              height: 52.v,
                              width: 226.h,
                              text: "ĐĂNG NHẬP",
                              buttonStyle: CustomButtonStyles.fillOrange,
                              buttonTextStyle: CustomTextStyles
                                  .titleMediumOnPrimaryContainer,
                              onPressed: () {
                                onTapNGNHP(context);
                              }),
                          SizedBox(height: 18.v),
                          RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Don't have an account? ",
                                    style: CustomTextStyles.bodyMediumPoppins),
                                TextSpan(
                                    text: "Đăng ký",
                                    style: CustomTextStyles.labelLargeOrange300,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RegisterScreen(),
                                        ),
                                      );
                                    },)
                              ]),
                              textAlign: TextAlign.left)
                        ])))));
  }

  /// Navigates to the forgetPasswordScreen when the action is triggered.
  onTapTxtQuNMTKhU(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.forgetPasswordScreen);
  }

  /// Navigates to the homeScreen when the action is triggered.
  onTapNGNHP(BuildContext context) {
    FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: inputController.text).then((value) => {
      Navigator.pushNamed(context, AppRoutes.homeScreen)
    }).catchError((error, stackTrace) {
      print("Error ${error.toString()}");
    });

  }
}
