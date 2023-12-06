import 'package:flutter/material.dart' hide SearchController;
import 'package:rbooks/core/app_export.dart';

// ignore: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService1 {
  Future<List<String>> fetchTopBooks() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection('sach').orderBy('last_update', descending: true).limit(4).get();

    List<String> topBooks = [];

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String tenSach = data['ten_sach'] ?? '';
      topBooks.add(tenSach);
    });

    return topBooks;
  }
}
class ChipviewtwentysixItemWidget extends StatelessWidget {
  final String tenSach;

  const ChipviewtwentysixItemWidget({
    Key? key,
    required this.tenSach,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.all(10.h),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        tenSach,
        style: TextStyle(
          color: theme.colorScheme.errorContainer.withOpacity(1),
          fontSize: 12.fSize,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
      ),
      selected: false,
      backgroundColor: appTheme.gray40001,
      selectedColor: appTheme.gray40001,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(
          17.h,
        ),
      ),
    );
  }
}

