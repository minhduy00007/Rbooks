import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/widgets/app_bar/appbar_leading_image.dart';
import 'package:rbooks/widgets/app_bar/appbar_subtitle.dart';
import 'package:rbooks/widgets/app_bar/custom_app_bar.dart';
import 'package:rbooks/widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addCategory(String categoryName) async {
    await _firestore.collection('the_loai').add({
      'ten_the_loai': categoryName,
    });
  }
}


class CategoryAddScreen extends StatelessWidget {
  final TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 7.h, vertical: 35.v),
          child: Column(
            children: [
              _buildComponentSeventeen(context),
              Spacer(),
              SizedBox(height: 6.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomElevatedButton(
                    width: 85.h,
                    text: "Thêm",
                    onPressed: () {
                      onTapThem(context);
                    },
                  ),
                  CustomElevatedButton(
                    width: 85.h,
                    text: "Hủy",
                    margin: EdgeInsets.only(left: 61.h),
                    buttonStyle: CustomButtonStyles.fillRedA,
                    onPressed: () {
                      onTapHy(context);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 44.v,
      leadingWidth: 37.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeftOnprimary,
        margin: EdgeInsets.only(left: 13.h, top: 10.v, bottom: 10.v),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      centerTitle: true,
      title: AppbarSubtitle(text: "Thêm thể loại"),
    );
  }

  Widget _buildComponentSeventeen(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 7.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 9.v),
            child: Text("Thể loại:", style: theme.textTheme.titleSmall),
          ),
          SizedBox(width: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            child: CustomTextFormField(
              controller: inputController,
              hintText: "Nhập thể loại",
              textInputType: TextInputType.emailAddress,
              width: 250,
            ),
          ),
        ],
      ),
    );
  }

  onTapArrowLeft(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.adminMenu);
  }

  onTapHy(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.adminMenu);
  }

  onTapThem(BuildContext context) async {
    String categoryName = inputController.text.trim();

    if (categoryName.isNotEmpty) {
      await FirestoreService().addCategory(categoryName);
      Navigator.pushNamed(context, AppRoutes.categoryAdminScreen);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng nhập tên thể loại.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
