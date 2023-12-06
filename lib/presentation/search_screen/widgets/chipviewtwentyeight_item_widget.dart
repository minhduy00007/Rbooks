import 'package:flutter/material.dart' hide SearchController;
import 'package:rbooks/core/app_export.dart';

// ignore: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService3 {
  Future<List<String>> searchBooks(String searchKeyword) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('sach')
        .where('ten_sach', isGreaterThanOrEqualTo: searchKeyword)
        .where('ten_sach', isLessThan: searchKeyword + 'z') // Đảm bảo tìm kiếm theo ký tự
        .get();

    List<String> searchResults = [];

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String tenSach = data['ten_sach'] ?? '';
      searchResults.add(tenSach);
    });

    return searchResults;
  }

}

class ChipviewtwentyeightItemWidget extends StatelessWidget {
  final String author;

  const ChipviewtwentyeightItemWidget({
    Key? key,
    required this.author,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawChip(
      // ... (rest of the code)
      label: Text(
        author,
        // ... (rest of the text style)
      ),
    );
  }
}

