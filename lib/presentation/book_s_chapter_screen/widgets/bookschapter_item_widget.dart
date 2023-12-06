import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/presentation/book_s_chapter_update_screen/book_s_chapter_update_screen.dart';

import '../book_s_chapter_screen.dart';

// ignore: must_be_immutable
class BookschapterItemWidget extends StatelessWidget {
  final String chapterName;
  final String lastUpdate;

  const BookschapterItemWidget({
    Key? key,
    required this.chapterName,
    required this.lastUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 2.h,
        vertical: 1.v,
      ),
      decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 12.v),
          Text(
            " $chapterName", // Use the provided chapterName
            style: theme.textTheme.titleSmall,
          ),
          SizedBox(height: 12.v),
          Padding(
            padding: EdgeInsets.only(left: 5.h),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Call the function to delete the chapter
                    onDeleteChapter(context, chapterName);
                  },
                  child: CustomImageView(
                    imagePath: ImageConstant.imgTrash,
                    height: 22.v,
                    width: 19.h,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    try {
                      // Assuming you have the document ID for the chapter
                      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                          .collection('chuong')
                          .where('ten_chuong', isEqualTo: chapterName)
                          .get();

                      if (querySnapshot.docs.isNotEmpty) {
                        String documentId = querySnapshot.docs.first.id;

                        // Navigate to the update screen and pass the documentId
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookSChapterUpdateScreen(chuongId: documentId),
                          ),
                        );
                      } else {
                        print('Chapter not found');
                      }
                    } catch (e) {
                      print('Error fetching chapter ID: $e');
                    }
                  },
                  child: CustomImageView(
                    imagePath: ImageConstant.imgOffer,
                    height: 22.adaptSize,
                    width: 22.adaptSize,
                    margin: EdgeInsets.only(left: 26.h),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void onDeleteChapter(BuildContext context, String chapterName) async {
  try {
    // Assuming you have the document ID for the chapter
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('chuong')
        .where('ten_chuong', isEqualTo: chapterName)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      String documentId = querySnapshot.docs.first.id;
      await FirebaseFirestore.instance.collection('chuong').doc(documentId).delete();

      // Display a confirmation message
      print('Chapter deleted successfully');

      // Reload the page
      Navigator.of(context).pop(); // Pop the current screen
    } else {
      print('Chapter not found');
    }
  } catch (e) {
    print('Error deleting chapter: $e');
  }
}