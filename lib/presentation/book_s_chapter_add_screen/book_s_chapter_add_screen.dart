import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/widgets/app_bar/custom_app_bar.dart';
import 'package:rbooks/widgets/custom_elevated_button.dart';

import '../../widgets/app_bar/appbar_subtitle_five.dart';

class BookSChapterAddScreen extends StatelessWidget {
  final sachId;
  const BookSChapterAddScreen({Key? key, required this.sachId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController chapterNameController = TextEditingController();
    TextEditingController noiDungController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context, chapterNameController),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 6.v),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.v),
                  child: Text("Nội dung:", style: theme.textTheme.titleSmall),
                ),
                _buildScrollableInputArea(noiDungController),
                SizedBox(height: 38.v),
                Padding(
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
                        text: "Thêm",
                        onPressed: () {
                          onTapThem(context, chapterNameController, noiDungController);
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
                SizedBox(height: 5.v)
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, TextEditingController chapterNameController) {
    return CustomAppBar(
      centerTitle: true,
      title: Row(
        children: [
          AppbarSubtitleFive(
            text: "Tên chương:",
            margin: EdgeInsets.only(top: 10.v, bottom: 3.v, left: 11.v),
          ),
          Container(
            height: 40,
            width: 250,
            margin: EdgeInsets.symmetric(horizontal: 5.h),
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: chapterNameController,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Nhập tên chương",
                border: InputBorder.none,
              ),
              style: CustomTextStyles.bodySmall11_1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableInputArea(TextEditingController noiDungController) {
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
                controller: noiDungController,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Nhập nội dung",
                  border: InputBorder.none,
                ),
                style: CustomTextStyles.bodySmall11_1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  onTapImgArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  onTapThem(BuildContext context, TextEditingController chapterNameController, TextEditingController noiDungController) async {
    try {
      DateTime now = DateTime.now();
      String formattedDate = "${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute}:${now.second}";
      String sachId = this.sachId;

      await FirebaseFirestore.instance.collection('chuong').add({
        'ten_chuong': chapterNameController.text,
        'noi_dung_chuong': noiDungController.text,
        'last_update': formattedDate,
        'id_sach': sachId,
      });

      Navigator.pop(context);
    } catch (e) {
      print('Error adding chapter: $e');
    }
  }

  onTapHy(BuildContext context) {
    Navigator.pop(context);
  }
}
