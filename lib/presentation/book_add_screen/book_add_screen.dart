import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/widgets/app_bar/appbar_leading_image.dart';
import 'package:rbooks/widgets/app_bar/appbar_subtitle.dart';
import 'package:rbooks/widgets/app_bar/custom_app_bar.dart';
import 'package:rbooks/widgets/custom_elevated_button.dart';
import 'package:rbooks/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class BookAddScreen extends StatelessWidget {
  BookAddScreen({Key? key}) : super(key: key);

  TextEditingController sachController = TextEditingController();
  TextEditingController tacgiaController = TextEditingController();
  TextEditingController xuatbanController = TextEditingController();
  TextEditingController theloaiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 7.h, vertical: 5.v),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 112.v,
                  width: 74.h,
                  padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 44.v),
                  decoration: AppDecoration.outlineErrorContainer.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder10,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      String? imageUrl =
                      await _pickImage(DateTime.now().millisecondsSinceEpoch.toString());
                      if (imageUrl != null) {
                        // Xử lý imageUrl, có thể lưu vào Firestore hoặc thực hiện các tác vụ khác
                        print("URL ảnh: $imageUrl");
                      }
                    },
                    child: CustomImageView(
                      imagePath: ImageConstant.imgFlipCameraIos,
                      height: 24.adaptSize,
                      width: 24.adaptSize,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                SizedBox(height: 42.v),
                Padding(
                  padding: EdgeInsets.only(left: 7.h),
                  child: _buildComponentNineteen(context),
                ),
                SizedBox(height: 15.v),
                _buildComponentEighteen(context),
                SizedBox(height: 15.v),
                Padding(
                  padding: EdgeInsets.only(left: 7.h),
                  child: _buildComponentTwenty(context),
                ),
                SizedBox(height: 12.v),
                Padding(
                  padding: EdgeInsets.only(left: 7.h),
                  child: _buildComponentTwenty1(context),
                ),
                SizedBox(height: 12.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 17.h),
                    child: Text("Mô tả:", style: theme.textTheme.titleSmall),
                  ),
                ),
                SizedBox(height: 23.v),
                _buildFrameTwelve(context),
                SizedBox(height: 29.v),
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
                    ),
                  ],
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
      height: 36.v,
      leadingWidth: 37.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeftOnprimary,
        margin: EdgeInsets.only(left: 13.h, top: 10.v, bottom: 2.v),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      centerTitle: true,
      title: AppbarSubtitle(text: "Thêm sách"),
    );
  }

  Widget _buildComponentEighteen(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 7.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.v, bottom: 8.v),
            child: Text("Tác giả:", style: theme.textTheme.titleSmall),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 19.h),
              child: CustomTextFormField(
                controller: tacgiaController,
                hintText: "Tên tác giả",
                hintStyle: CustomTextStyles.bodyMediumPoppinsLight,
                textInputAction: TextInputAction.done,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFrameTwelve(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 9.h, vertical: 5.v),
        decoration: AppDecoration.fillOnPrimaryContainer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 1.v),
            SizedBox(
              width: 323.h,
              height: 300.v,
              child: TextField(
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Nhập nội dung",
                  border: InputBorder.none,
                ),
                style: CustomTextStyles.chapterLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComponentNineteen(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.v, bottom: 10.v),
          child: Text("Tên sách:", style: theme.textTheme.titleSmall),
        ),
        SizedBox(width: 7.h),
        Expanded(
          child: CustomTextFormField(
            controller: sachController,
            hintText: "Nhập tên sách",
            hintStyle: CustomTextStyles.bodyMediumPoppinsLight,
            textInputAction: TextInputAction.next,
          ),
        ),
      ],
    );
  }

  Widget _buildComponentTwenty(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.v, bottom: 10.v),
          child: Text("Xuất bản:", style: theme.textTheme.titleSmall),
        ),
        SizedBox(width: 7.h),
        Expanded(
          child: CustomTextFormField(
            controller: xuatbanController,
            hintText: "Nhập ngày xuất bản",
            hintStyle: CustomTextStyles.bodyMediumPoppinsLight,
            textInputAction: TextInputAction.next,
          ),
        ),
      ],
    );
  }
  Widget _buildComponentTwenty1(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.v, bottom: 10.v),
          child: Text("Thể loại:", style: theme.textTheme.titleSmall),
        ),
        SizedBox(width: 7.h),
        Expanded(
          child: CustomTextFormField(
            controller: theloaiController,
            hintText: "Nhập thể loại",
            hintStyle: CustomTextStyles.bodyMediumPoppinsLight,
            textInputAction: TextInputAction.next,
          ),
        ),
      ],
    );
  }

  onTapArrowLeft(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.adminHomeScreen);
  }

  onTapHy(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.adminHomeScreen);
  }

  Future<String?> _pickImage(String bookId) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      try {
        firebase_storage.Reference storageReference =
        firebase_storage.FirebaseStorage.instance.ref().child('$bookId.jpg');

        await storageReference.putFile(File(pickedFile.path!));

        // Trả về bookId thay vì downloadURL
        return bookId;
      } catch (e) {
        print('Error uploading image: $e');
      }
    }

    return null;
  }


  onTapThem(BuildContext context) async {
    DateTime now = DateTime.now();
    String formattedDate = "${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute}:${now.second}";

    try {
      String tenSach = sachController.text;
      String tacGia = tacgiaController.text;
      String ngayXuatBan = xuatbanController.text;
      String gioiThieuSach = '';
      String theLoai = theloaiController.text;

      // Sử dụng tên ảnh làm ID của tài liệu
      String? imageUrl = await _pickImage(now.millisecondsSinceEpoch.toString());
      List<String> theLoaiList = theLoai.split(',');

      await FirebaseFirestore.instance.collection('sach').doc(imageUrl).set({
        'ten_sach': tenSach,
        'tac_gia': tacGia,
        'ngay_xuat_ban': ngayXuatBan,
        'gioi_thieu_sach': gioiThieuSach,
        'last_update': formattedDate,
        'so_luot_like': 0,
        'so_luot_doc': 0,
        'so_luot_rating': 0,
        'image_url': imageUrl,
        'the_loai': theLoaiList,
      });

      Navigator.pushNamed(context, AppRoutes.adminHomeScreen);
    } catch (e) {
      print('Error adding book: $e');
    }
  }
}
