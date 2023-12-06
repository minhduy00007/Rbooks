import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';

// ignore: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../catefory_book_screen/catefory_book_screen.dart';

class FirestoreService {
  Future<List<String>> fetchGenresFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection('sach').get();

    List<String> genres = [];

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      List<dynamic> genresList = data['the_loai'] ?? [];
      genres.addAll(genresList.map((genre) => genre.toString()));
    });

    return genres.toSet().toList(); // Remove duplicates
  }
}
class TwentyfiveItemWidget extends StatelessWidget {
  final String genre;

  const TwentyfiveItemWidget({
    Key? key,
    required this.genre,
  }) : super(key: key);

  void _onItemPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryBookScreen(genre: genre),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onItemPressed(context);
      },
      child: RawChip(
        padding: EdgeInsets.symmetric(
          horizontal: 30.h,
          vertical: 12.v,
        ),
        showCheckmark: false,
        labelPadding: EdgeInsets.zero,
        label: Text(
          genre,
          style: TextStyle(
            color: theme.colorScheme.errorContainer.withOpacity(1),
            fontSize: 15.fSize,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
        selected: false,
        backgroundColor: theme.colorScheme.onPrimaryContainer,
        selectedColor: theme.colorScheme.onPrimaryContainer,
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(
            10.h,
          ),
        ),
      ),
    );
  }
}