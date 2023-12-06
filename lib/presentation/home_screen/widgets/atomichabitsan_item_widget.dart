import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:intl/intl.dart';

import '../../book_screen/book_screen.dart';
Future<List<DocumentSnapshot>> fetchDataFromFirestore() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('sach')
      .orderBy('last_update', descending: true) // Sắp xếp theo last_update giảm dần (từ mới nhất đến cũ nhất)
      .get();

  return querySnapshot.docs;
}
// ignore: must_be_immutable
class AtomichabitsanItemWidget extends StatelessWidget {
  final String title;
  final String author;
  final String documentId;

  const AtomichabitsanItemWidget({
    Key? key,
    required this.title,
    required this.author,
    required this.documentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to BookTabContainerScreen when the item is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookScreen(documentId: documentId),
          ),
        );
      },
      child: FutureBuilder<String>(
        future: fetchImageUrl(documentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          String imageUrl = snapshot.data ?? '';

          return SizedBox(
            width: 77.h,
            child: Padding(
              padding: EdgeInsets.only(
                top: 2.v,
                bottom: 8.v,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    imgURL: imageUrl,
                    height: 113.v,
                    width: 77.h,
                    radius: BorderRadius.circular(
                      10.h,
                    ),
                    alignment: Alignment.center,
                  ),
                  SizedBox(height: 11.v),
                  SizedBox(
                    width: 74.h,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "$title\n",
                            style: CustomTextStyles.poppinsErrorContainerRegular,
                          ),
                          TextSpan(
                            text: "$author\n\n\n",
                            style: CustomTextStyles.poppinsErrorContainer,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<String> fetchImageUrl(String documentId) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('$documentId.jpg');
      String imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error fetching image URL: $e');
      return '';
    }
  }
}