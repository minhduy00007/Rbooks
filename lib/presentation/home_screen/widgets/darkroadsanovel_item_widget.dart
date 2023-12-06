import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rbooks/presentation/book_screen/book_screen.dart';


class FirestoreService {
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchDataFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('sach')
        .orderBy('so_luot_doc', descending: true)
        .get();

    return querySnapshot.docs;
  }

}

class DarkroadsanovelItemWidget extends StatelessWidget {
  final String title;
  final String author;
  final String documentId;

  const DarkroadsanovelItemWidget({
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

          return Container(
            margin: EdgeInsets.only(bottom: 1.v),
            padding: EdgeInsets.all(1.h),
            width: 87.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imgURL: imageUrl,
                  height: 112.v,
                  width: 73.h,
                  radius: BorderRadius.circular(10.h),
                ),
                SizedBox(height: 6.v),
                SizedBox(
                  width: 73.h,
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
                SizedBox(height: 7.v),
              ],
            ),
          );
        },
      ),
    );
  }
  Future<String> fetchImageUrl(String bookId) async {
    try {
      // Lấy đối tượng Firebase Storage
      FirebaseStorage storage = FirebaseStorage.instance;

      // Lấy tham chiếu đến hình ảnh trong Firebase Storage dựa trên ID của sách
      Reference ref = storage.ref().child('$bookId.jpg');

      // In ra thông báo khi bắt đầu tải hình ảnh
      print('Start fetching image URL for book $bookId');

      // Lấy đường dẫn URL của hình ảnh
      String imageUrl = await ref.getDownloadURL();

      // In ra thông báo khi hình ảnh đã được tải thành công
      print('Image URL fetched successfully: $imageUrl');

      // In ra giá trị của imageUrl trước khi trả về
      print('Image URL: $imageUrl');

      return imageUrl;
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error fetching image URL: $e');
      return ''; // Trả về chuỗi rỗng hoặc một URL mặc định
    }
  }}