import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/presentation/book_screen/book_screen.dart';
import 'package:rbooks/widgets/app_bar/appbar_leading_image.dart';
import 'package:rbooks/widgets/app_bar/appbar_title.dart';
import 'package:rbooks/widgets/app_bar/appbar_trailing_image.dart';
import 'package:rbooks/widgets/app_bar/custom_app_bar.dart';

class LikeScreen extends StatelessWidget {
  LikeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.h, 11.v, 20.h, 5.v),
            child: _fetchAndDisplayLikedBooks(context),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 35.v,
      leadingWidth: 41.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeftErrorcontainer,
        margin: EdgeInsets.only(left: 11.h),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      title: AppbarTitle(
        text: "Danh mục yêu thích",
        margin: EdgeInsets.only(left: 11.h),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgVectorDeepOrange100,
          margin: EdgeInsets.fromLTRB(11.h, 9.v, 53.h, 8.v),
        ),
      ],
    );
  }

  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  Widget _fetchAndDisplayLikedBooks(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Text('User not logged in');
    }

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (userSnapshot.hasError) {
          return Text('Error fetching user document: ${userSnapshot.error}');
        } else if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
          return Text('User document not found');
        } else {
          final likedBooks = userSnapshot.data!['truyen_yeu_thich'] ?? [];

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20.v,
            ),
            itemCount: likedBooks.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              String bookId = likedBooks[index];
              return _buildLikedBook(context, bookId);
            },
          );
        }
      },
    );
  }

  Widget _buildLikedBook(BuildContext context, String bookId) {
    return FutureBuilder<String>(
      future: _getImageUrl(bookId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error loading book image: ${snapshot.error}');
        } else {
          String imageUrl = snapshot.data!;
          return GestureDetector(
            onTap: () {
              _handleImageTap(context, bookId);
            },
            child: Column(
              children: [
                Container(
                  height: 150.v,
                  width: 100.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8.v),
              ],
            ),
          );
        }
      },
    );
  }

  void _handleImageTap(BuildContext context, String bookId) {
    // Implement the navigation or any other action when an image is tapped
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookScreen(documentId: bookId),
      ),
    );
  }

  Future<String> _getImageUrl(String bookId) async {
    try {
      Reference ref = FirebaseStorage.instance.ref('$bookId.jpg');
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error loading image for book $bookId: $e');
      return 'assets/placeholder_image.jpg';
    }
  }
}
