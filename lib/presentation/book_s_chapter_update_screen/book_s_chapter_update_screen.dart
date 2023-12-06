import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/widgets/app_bar/appbar_subtitle_five.dart';
import 'package:rbooks/widgets/app_bar/appbar_subtitle_four.dart';
import 'package:rbooks/widgets/app_bar/custom_app_bar.dart';
import 'package:rbooks/widgets/custom_elevated_button.dart';

import '../../widgets/app_bar/appbar_title_searchview.dart';
import '../../widgets/custom_text_form_field.dart';

class BookSChapterUpdateScreen extends StatefulWidget {
  final chuongId;

  BookSChapterUpdateScreen({Key? key, required this.chuongId}) : super(key: key);

  @override
  _BookSChapterUpdateScreenState createState() => _BookSChapterUpdateScreenState();
}

class _BookSChapterUpdateScreenState extends State<BookSChapterUpdateScreen> {
  TextEditingController tenChuongController = TextEditingController();
  TextEditingController noiDungController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch chapter details from Firebase when the screen is initialized
    fetchChapterDetails();
  }

  Future<void> fetchChapterDetails() async {
    try {
      // Assuming you have the document ID for the chapter
      DocumentSnapshot chapterSnapshot = await FirebaseFirestore.instance
          .collection('chuong')
          .doc(widget.chuongId)
          .get();

      if (chapterSnapshot.exists) {
        // Set the values of tenChuong and noiDung from Firebase
        setState(() {
          tenChuongController.text = chapterSnapshot['ten_chuong'];
          noiDungController.text = chapterSnapshot['noi_dung_chuong'];
        });
      } else {
        print('Chapter not found');
      }
    } catch (e) {
      print('Error fetching chapter details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 2.v),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildFifty(context),
                SizedBox(height: 14.v),
                _buildScrollableInputArea(),
                SizedBox(height: 14.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(right: 68.h),
                    child: Row(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgArrowLeftOnprimary,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                          margin: EdgeInsets.only(top: 9.v, bottom: 8.v),
                          onTap: () {
                            onTapImgArrowLeft(context);
                          },
                        ),
                        Spacer(flex: 34),
                        CustomElevatedButton(
                          width: 85.h,
                          text: "Cập nhật",
                          onPressed: () {
                            onTapCapNhat(context);
                          },
                        ),
                        Spacer(flex: 65),
                        CustomElevatedButton(
                          width: 85.h,
                          text: "Hủy",
                          buttonStyle: CustomButtonStyles.fillRedA,
                          onPressed: () {
                            onTapHy(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5.v),
              ],
            ),
          ),
        ),
      ),
    );
  }
  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        centerTitle: true,
        title: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.v, bottom: 8.v),
              child: Text("Tên chương:", style: theme.textTheme.titleSmall),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 19.h),
                child: CustomTextFormField(
                  controller: tenChuongController,
                  hintText: "Chương",
                  hintStyle: CustomTextStyles.bodyMediumPoppinsLight,
                  textInputAction: TextInputAction.done,
                ),
              ),
            ),
          ],
        ),);
  }

  /// Section Widget
  Widget _buildFifty(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.v),
          child: Text("Nội dung:", style: theme.textTheme.titleSmall),
        ),
      ],
    );
  }
  Widget _buildScrollableInputArea() {
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
              height: 600.v,
              child: TextField(
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Nhập nội dung",
                  border: InputBorder.none,
                ),
                style: CustomTextStyles.chapterLarge,
                controller: noiDungController,
              ),
            ),
          ],
        ),
      ),
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
            child: Text("Tên chương:", style: theme.textTheme.titleSmall),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 19.h),
              child: CustomTextFormField(
                controller: tenChuongController,
                hintText: "Chương",
                hintStyle: CustomTextStyles.bodyMediumPoppinsLight,
                textInputAction: TextInputAction.done,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onTapCapNhat(BuildContext context) async {
    try {
      // Update chapter details on Firebase
      await FirebaseFirestore.instance.collection('chuong').doc(widget.chuongId).update({
        'ten_chuong': tenChuongController.text,
        'noi_dung_chuong': noiDungController.text,
      });

      // Display a confirmation message
      print('Chapter updated successfully');

      // Navigate back to the previous screen
      Navigator.of(context).pop();
    } catch (e) {
      print('Error updating chapter: $e');
    }
  }
}
  /// Navigates to the bookSChapterScreen when the action is triggered.
  onTapImgArrowLeft(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.bookSChapterScreen);
  }

  /// Navigates to the bookSChapterScreen when the action is triggered.
  onTapHy(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.bookSChapterScreen);
  }

