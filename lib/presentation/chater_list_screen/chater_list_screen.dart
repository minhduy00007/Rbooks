import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../chater_list_screen/widgets/chaterlist_item_widget.dart';

import 'package:flutter/material.dart';

class ChaterListScreen extends StatelessWidget {
  final String documentId;

  const ChaterListScreen({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Padding(
          padding: EdgeInsets.only(left: 20.h, top: 27.v, right: 17.h),
          child: FutureBuilder<List<String>>(
            future: fetchTenChuongListFromFirestore(documentId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              List<String>? tenChuongList = snapshot.data;

              if (tenChuongList == null || tenChuongList.isEmpty) {
                return Text('Không có dữ liệu.');
              }

              return ListView.separated(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 9.v);
                },
                itemCount: tenChuongList.length,
                itemBuilder: (context, index) {
                  return ChaterlistItemWidget(
                    documentId: this.documentId,
                    tenChuong: tenChuongList[index],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 41.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.only(left: 17.h, top: 15.v, bottom: 16.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        title: AppbarTitle(
            text: "Danh sách chương", margin: EdgeInsets.only(left: 44.h)));
  }
  Future<List<String>> fetchTenChuongListFromFirestore(String documentId) async {
    try {
      QuerySnapshot chuongQuery = await FirebaseFirestore.instance
          .collection("chuong")
          .where("id_sach", isEqualTo: documentId)
          .get();

      if (chuongQuery.docs.isNotEmpty) {
        List<Map<String, dynamic>> chuongDataList = chuongQuery.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

        // Chuyển đổi chuỗi "last_update" thành DateTime và sắp xếp
        chuongDataList.sort((a, b) {
          DateTime dateTimeA = DateFormat('dd/MM/yyyy HH:mm:ss').parse(a["last_update"]);
          DateTime dateTimeB = DateFormat('dd/MM/yyyy HH:mm:ss').parse(b["last_update"]);
          return dateTimeB.compareTo(dateTimeA); // Sắp xếp giảm dần theo thời gian
        });

        List<String> tenChuongList = chuongDataList.map((chuongData) => chuongData["ten_chuong"] as String).toList();
        return tenChuongList;
      }
    } catch (e) {
      print("Lỗi khi lấy dữ liệu từ Firebase: $e");
    }

    return []; // Trả về một giá trị mặc định nếu không thành công
  }

}

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
