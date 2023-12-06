import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/presentation/readbook_screen/readbook_screen.dart';

class ChaterlistItemWidget extends StatelessWidget {
  final String documentId;
  final String tenChuong;

  const ChaterlistItemWidget({
    Key? key,
    required this.documentId,
    required this.tenChuong,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // Lấy id của chương được click
        String chuongId = await fetchChuongIdFromFirestore(documentId, tenChuong);

        // Chuyển qua trang mới và truyền id của chương
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReadbookScreen(documentId: chuongId),
          ),
        );
      },
      child: Container(
        width: 338.h,
        padding: EdgeInsets.symmetric(
          horizontal: 2.h,
          vertical: 13.v,
        ),
        decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder10,
        ),
        child: Text(
          replaceChuongTitle(tenChuong),
          style: theme.textTheme.titleSmall,
        ),
      ),
    );
  }

  String replaceChuongTitle(String tenChuong) {
    String soChuong = RegExp(r'\d+').firstMatch(tenChuong)?.group(0) ?? '';
    return " $tenChuong";
  }

  Future<String> fetchChuongIdFromFirestore(String documentId, String tenChuong) async {
    try {
      QuerySnapshot chuongQuery = await FirebaseFirestore.instance
          .collection("chuong")
          .where("id_sach", isEqualTo: documentId)
          .where("ten_chuong", isEqualTo: tenChuong)
          .get();

      if (chuongQuery.docs.isNotEmpty) {
        return chuongQuery.docs.first.id; // Trả về id của chương đầu tiên (nếu có nhiều chương trùng tên)
      }
    } catch (e) {
      print("Lỗi khi lấy dữ liệu từ Firebase: $e");
    }

    return ""; // Trả về một giá trị mặc định nếu không thành công
  }
}
