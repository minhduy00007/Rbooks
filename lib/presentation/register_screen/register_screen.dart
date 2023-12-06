import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/presentation/login_screen/login_screen.dart';
import 'package:rbooks/widgets/custom_elevated_button.dart';
import 'package:rbooks/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  TextEditingController inputFieldController = TextEditingController();

  TextEditingController emailFieldController = TextEditingController();

  TextEditingController inputFieldController1 = TextEditingController();

  TextEditingController inputFieldController2 = TextEditingController();

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
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 48.v),
                          RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Chào mừng đến với ",
                                    style:
                                        CustomTextStyles.headlineSmallPoppins),
                                TextSpan(
                                    text: "Rbook",
                                    style: CustomTextStyles
                                        .headlineSmallPoppinsOnError),
                                TextSpan(
                                    text: "!",
                                    style:
                                        CustomTextStyles.headlineSmallPoppins),
                                TextSpan(text: " ")
                              ]),
                              textAlign: TextAlign.left),
                          SizedBox(height: 11.v),
                          Text("Let's help you meet up your task.",
                              style: CustomTextStyles.bodyMediumPoppins13),
                          SizedBox(height: 92.v),
                          _buildInputField(context),
                          SizedBox(height: 17.v),
                          _buildEmailField(context),
                          SizedBox(height: 17.v),
                          _buildInputField1(context),
                          SizedBox(height: 17.v),
                          _buildInputField2(context),
                          SizedBox(height: 97.v),
                          _buildRegisterButton(context),
                          SizedBox(height: 18.v),
                          RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Already have an account? ",
                                    style: CustomTextStyles.bodyMediumPoppins),
                                TextSpan(
                                    text: " Đăng nhập",
                                    style: CustomTextStyles.labelLargeOrange300,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginScreen(),
                                        ),
                                      );
                                    },)
                              ]),
                              textAlign: TextAlign.left)
                        ])))));
  }

  /// Section Widget
  Widget _buildInputField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h, right: 10.h),
        child: CustomTextFormField(
            controller: inputFieldController, hintText: "Nhập tên của bạn"));
  }

  /// Section Widget
  Widget _buildEmailField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h, right: 10.h),
        child: CustomTextFormField(
            controller: emailFieldController,
            hintText: "Nhập email của ",
            textInputType: TextInputType.emailAddress));
  }

  /// Section Widget
  Widget _buildInputField1(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 8.h, right: 9.h),
        child: CustomTextFormField(
            controller: inputFieldController1, hintText: "Nhập mật khẩu",
            textInputType: TextInputType.visiblePassword,
          obscureText: true,));
  }

  /// Section Widget
  Widget _buildInputField2(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.h),
        child: CustomTextFormField(
            controller: inputFieldController2,
            hintText: "Nhập lại mật khẩu",
            textInputType: TextInputType.visiblePassword,
          obscureText: true,));
  }

  /// Section Widget
  Widget _buildRegisterButton(BuildContext context) {
    return CustomElevatedButton(
        height: 52.v,
        width: 226.h,
        text: "ĐĂNG KÝ",
        buttonStyle: CustomButtonStyles.fillOrange,
        buttonTextStyle: CustomTextStyles.titleMediumOnPrimaryContainer,
        onPressed: () {
          onTapRegisterButton(context);
        });
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapRegisterButton(BuildContext context) async {
    try {
      // Kiểm tra xem mật khẩu và nhập lại mật khẩu có giống nhau không
      if (inputFieldController1.text != inputFieldController2.text) {
        // Hiển thị thông báo hoặc thực hiện các hành động khác nếu mật khẩu không trùng khớp
        print("Mật khẩu và nhập lại mật khẩu không khớp");
        return;
      }

      // Tạo người dùng trong Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailFieldController.text,
        password: inputFieldController1.text,
      );

      // Lấy UID của người dùng mới
      String uid = userCredential.user?.uid ?? '';

      // Thêm thông tin người dùng vào Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'email': emailFieldController.text,
        'ho_ten': inputFieldController.text,
        'password': inputFieldController1.text,
        'truyen_da_doc': [],
        'last_update': "",
        'sach_id': "",
        'truyen_yeu_thich': [
          {
            'sach_id': "",
          },
        ],
        'username': '',
        'quyen_admin':false
      });

      // Chuyển hướng đến màn hình đăng nhập sau khi đăng ký thành công
      Navigator.pushNamed(context, AppRoutes.loginScreen);
    } catch (error) {
      print("Error ${error.toString()}");
    }
  }
}
