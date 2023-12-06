import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/widgets/app_bar/appbar_leading_image.dart';
import 'package:rbooks/widgets/app_bar/appbar_subtitle_two.dart';
import 'package:rbooks/widgets/app_bar/custom_app_bar.dart';

class ReadbookScreen extends StatelessWidget {
  final String documentId;

  const ReadbookScreen({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchChuongDataFromFirestore(documentId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }

        Map<String, dynamic>? chuongData = snapshot.data;

        if (chuongData == null) {
          return Scaffold(
            body: Center(
              child: Text('Không có dữ liệu.'),
            ),
          );
        }

        String tenChuong = chuongData['ten_chuong'];
        String noiDungChuong = chuongData['noi_dung_chuong'];

        return SafeArea(
          child: Scaffold(
            appBar: _buildAppBar(context, tenChuong),
            body: Container(
              width: 326.h,
              margin: EdgeInsets.symmetric(horizontal: 24.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 326.h,
                      child: Text(
                        noiDungChuong.replaceAll("\\n", "\n"),
                        maxLines: 40,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        style: CustomTextStyles.chapterLarge,
                      ),
                    ),
                    SizedBox(height: 17.v),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context, String tenChuong) {
    return CustomAppBar(
      height: 42.v,
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgClose,
        margin: EdgeInsets.only(left: 25.h, top: 18.v, bottom: 9.v),
        onTap: () {
          onTapClose(context);
        },
      ),
      centerTitle: true,
      title: AppbarSubtitleTwo(text: tenChuong),
    );
  }

  /// Navigates back to the previous screen.
  onTapClose(BuildContext context) {
    Navigator.pop(context);
  }

  Future<Map<String, dynamic>> fetchChuongDataFromFirestore(String documentId) async {
    try {
      DocumentSnapshot chuongDoc = await FirebaseFirestore.instance
          .collection("chuong")
          .doc(documentId)
          .get();

      if (chuongDoc.exists) {
        return chuongDoc.data() as Map<String, dynamic>;
      }
    } catch (e) {
      print("Lỗi khi lấy dữ liệu từ Firebase: $e");
    }

    return {}; // Trả về một giá trị mặc định nếu không thành công
  }
}
