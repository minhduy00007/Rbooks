import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/widgets/app_bar/appbar_leading_image.dart';
import 'package:rbooks/widgets/app_bar/appbar_title.dart';
import 'package:rbooks/widgets/app_bar/custom_app_bar.dart';
import 'package:rbooks/widgets/custom_elevated_button.dart';
import 'package:rbooks/widgets/custom_text_form_field.dart';

class InformationOneScreen extends StatefulWidget {
  InformationOneScreen({Key? key}) : super(key: key);

  @override
  _InformationOneScreenState createState() => _InformationOneScreenState();
}

class _InformationOneScreenState extends State<InformationOneScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController tnController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Gọi hàm để load dữ liệu người dùng khi widget được khởi tạo
    loadUserData();
  }

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
            padding: EdgeInsets.symmetric(horizontal: 34.h, vertical: 27.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 59.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgUserErrorcontainer,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                        margin: EdgeInsets.only(top: 3.v, bottom: 10.v),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 12.h),
                          child: CustomTextFormField(
                            controller: emailController,
                            hintText: "Email",
                            hintStyle: CustomTextStyles.bodySmallInter,
                            textInputType: TextInputType.emailAddress,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 31.v),
                Padding(
                  padding: EdgeInsets.only(right: 57.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgUserErrorcontainer,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                        margin: EdgeInsets.only(top: 15.v),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 12.h),
                          child: CustomTextFormField(
                            controller: tnController,
                            hintText: "Tên",
                            hintStyle: CustomTextStyles.bodySmallInter,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.v),
                CustomElevatedButton(
                  height: 37.v,
                  width: 212.h,
                  text: "Lưu",
                  margin: EdgeInsets.only(left: 38.h),
                  buttonStyle: CustomButtonStyles.fillPrimary,
                  buttonTextStyle: CustomTextStyles.bodySmallInter,
                  onPressed: () {
                    onTapLu(context);
                  },
                ),
                SizedBox(height: 5.v),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 46.v,
      leadingWidth: 53.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 29.h, top: 5.v, bottom: 17.v),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(text: "Thay đổi thông tin"),
    );
  }

  void loadUserData() async {
    try {
      // Lấy thông tin người dùng hiện tại
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Lấy dữ liệu người dùng từ Firestore
        DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        // Cập nhật giá trị của các trường dữ liệu tương ứng
        setState(() {
          emailController.text = user.email ?? "";
          tnController.text = userDoc.get('ho_ten') ?? ""; // Sửa đổi để lấy dữ liệu từ trường ho_ten
        });
      }
    } catch (error) {
      print('Lỗi khi load dữ liệu người dùng: $error');
    }
  }

  void updateUserData() async {
    try {
      // Lấy thông tin người dùng hiện tại
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Cập nhật dữ liệu người dùng trên Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'ho_ten': tnController.text,
          // Thêm các trường khác nếu có
        });

        print('Đã cập nhật thông tin người dùng thành công');
      }
    } catch (error) {
      print('Lỗi khi cập nhật thông tin người dùng: $error');
    }
  }

  void onTapArrowLeft(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.menu);
  }

  void onTapLu(BuildContext context) {
    updateUserData();
    Navigator.pushNamed(context, AppRoutes.accountScreen);
  }
}
