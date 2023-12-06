import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/widgets/app_bar/appbar_leading_image.dart';
import 'package:rbooks/widgets/app_bar/appbar_subtitle.dart';
import 'package:rbooks/widgets/app_bar/custom_app_bar.dart';
import 'package:rbooks/widgets/custom_elevated_button.dart';
import 'package:rbooks/widgets/custom_text_form_field.dart';

class BookupdateScreen extends StatefulWidget {
  final String documentId;

  BookupdateScreen({Key? key, required this.documentId}) : super(key: key);

  @override
  _BookupdateScreenState createState() => _BookupdateScreenState();
}

class _BookupdateScreenState extends State<BookupdateScreen> {
  late String imageUrl;
  TextEditingController tenSachController = TextEditingController();
  TextEditingController tacGiaController = TextEditingController();
  TextEditingController ngayXuatBanController = TextEditingController();
  TextEditingController gioiThieuController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Gọi hàm để lấy thông tin sách từ Firebase khi widget được khởi tạo
    fetchBookInfo();
    // Gọi hàm để lấy ảnh sách từ Firebase Storage
    fetchBookImage();
  }

  // Hàm để lấy thông tin sách từ Firebase
  Future<void> fetchBookInfo() async {
    try {
      DocumentSnapshot bookSnapshot = await FirebaseFirestore.instance.collection('sach').doc(widget.documentId).get();

      if (bookSnapshot.exists) {
        setState(() {
          tenSachController.text = bookSnapshot['ten_sach'] ?? "";
          ngayXuatBanController.text = bookSnapshot['ngay_xuat_ban'] ?? "";
          tacGiaController.text = bookSnapshot['tac_gia'] ?? "";
          gioiThieuController.text = bookSnapshot['gioi_thieu_sach'] ?? "";
        });
      }
    } catch (e) {
      print('Error fetching book info: $e');
    }
  }

  // Hàm để lấy ảnh sách từ Firebase Storage
  Future<void> fetchBookImage() async {
    try {
      // Tạo tên ảnh theo đúng định dạng: documentId.jpg
      String imageName = '${widget.documentId}.jpg';
      // Tạo đường dẫn trong Firebase Storage
      String imagePath = '$imageName';
      // Lấy URL download của ảnh
      String downloadURL = await firebase_storage.FirebaseStorage.instance.ref(imagePath).getDownloadURL();

      setState(() {
        imageUrl = downloadURL;
      });
    } catch (e) {
      print('Error fetching book image: $e');
    }
  }

  // Hàm để cập nhật thông tin sách lên Firebase
  Future<void> updateBookInfo() async {
    try {
      await FirebaseFirestore.instance.collection('sach').doc(widget.documentId).update({
        'ten_sach': tenSachController.text,
        'ngay_xuat_ban': ngayXuatBanController.text,
        'tac_gia': tacGiaController.text,
        'gioi_thieu_sach': gioiThieuController.text,
      });
      Navigator.pushNamed(context, AppRoutes.adminHomeScreen);

      // In case you want to show a success message, you can use:
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Book information updated successfully')));
    } catch (e) {
      print('Error updating book info: $e');
    }
  }

  Future<void> pickerImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Lấy tên ảnh hiện tại trên Firebase Storage
        String currentImageName = '${widget.documentId}.jpg';

        // Tạo tên mới cho ảnh mới
        String newImageName = '${widget.documentId}.jpg';

        // Tạo đường dẫn trong Firebase Storage cho ảnh hiện tại và ảnh mới
        String currentImagePath = '$currentImageName';
        String newImagePath = '$newImageName';

        // Lấy URL download của ảnh hiện tại
        String currentDownloadURL = await firebase_storage.FirebaseStorage.instance.ref(currentImagePath).getDownloadURL();

        // Xóa ảnh hiện tại
        await firebase_storage.FirebaseStorage.instance.ref(currentImagePath).delete();

        // Đưa ảnh mới lên Firebase Storage với tên mới
        await firebase_storage.FirebaseStorage.instance.ref(newImagePath).putFile(File(pickedFile.path));

        // Cập nhật imageUrl với đường dẫn mới
        setState(() {
          imageUrl = newImagePath;
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 9.h, vertical: 2.v),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // Gọi hàm mở picker khi người dùng click vào hình ảnh
                    pickerImage();
                  },
                  child: CustomImageView(
                    imgURL: imageUrl ?? ImageConstant.img7,
                    height: 112.v,
                    width: 74.h,
                    radius: BorderRadius.circular(10.h),
                  ),
                ),
                SizedBox(height: 38.v),
                _buildComponentEighteen1(context),
                SizedBox(height: 15.v),
                _buildComponentEighteen(context),
                SizedBox(height: 15.v),
                _buildComponentEighteen3(context),
                SizedBox(height: 19.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 3.h),
                    child: Text("Mô tả:", style: theme.textTheme.titleSmall),
                  ),
                ),
                SizedBox(height: 16.v),
                _buildFrameTwelve(context),
                SizedBox(height: 29.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomElevatedButton(
                      width: 85.h,
                      text: "Cập nhật",
                      onPressed: () {
                        updateBookInfo();
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
      height: 35.v,
      leadingWidth: 37.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeftOnprimary,
        margin: EdgeInsets.only(left: 13.h, top: 10.v, bottom: 1.v),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      centerTitle: true,
      title: AppbarSubtitle(text: "Cập nhật sách"),
    );
  }

  Widget _buildComponentEighteen(BuildContext context) {
    return Row(
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
              controller: tacGiaController,
              hintStyle: CustomTextStyles.bodyMediumPoppinsLight,
              textInputAction: TextInputAction.done,
              autofocus: false,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildComponentEighteen1(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.v, bottom: 8.v),
          child: Text("Tên sách:", style: theme.textTheme.titleSmall),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 19.h),
            child: CustomTextFormField(
              controller: tenSachController,
              hintStyle: CustomTextStyles.bodyMediumPoppinsLight,
              textInputAction: TextInputAction.done,
              autofocus: false,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildComponentEighteen3(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10.v, bottom: 8.v),
          child: Text("Xuất bản:", style: theme.textTheme.titleSmall),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 19.h),
            child: CustomTextFormField(
              controller: ngayXuatBanController,
              hintStyle: CustomTextStyles.bodyMediumPoppinsLight,
              textInputAction: TextInputAction.done,
              autofocus: false,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFrameTwelve(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 3.h, right: 9.h),
      padding: EdgeInsets.symmetric(horizontal: 9.h, vertical: 5.v),
      decoration: AppDecoration.fillOnPrimaryContainer,
      child: Column(
        children: [
          SizedBox(height: 9.v),
          SizedBox(
            width: 323.h,
            child: TextField(
              controller: gioiThieuController,
              maxLines: 16,
              decoration: InputDecoration(
                hintText: "Nhập mô tả sách...",
                hintStyle: CustomTextStyles.chapterLarge.copyWith(color: Colors.grey),
              ),
              style: CustomTextStyles.chapterLarge,
            ),
          ),
        ],
      ),
    );
  }


  void onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  void onTapHy(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.adminHomeScreen);
  }
}
