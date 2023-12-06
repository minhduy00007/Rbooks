import 'package:flutter/material.dart' hide SearchController;
import 'package:rbooks/core/app_export.dart';

// ignore: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService2 {
  Future<List<String>> fetchTopTenBooks() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection('sach').orderBy('so_luot_doc', descending: true).limit(10).get();

    List<String> topTenBooks = [];

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String tenSach = data['ten_sach'] ?? '';
      topTenBooks.add(tenSach);
    });

    return topTenBooks;
  }
}

class ChipviewtwentysevenItemWidget extends StatelessWidget {
  final String tenSach;

  const ChipviewtwentysevenItemWidget({
    Key? key,
    required this.tenSach,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.symmetric(
        horizontal: 9.h,
        vertical: 10.v,
      ),
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

