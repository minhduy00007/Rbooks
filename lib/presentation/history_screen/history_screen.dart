import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late User? _currentUser;
  List<String> _readBookIds = [];

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser != null) {
      await _getReadBookIds();
    }
  }

  Future<void> _getReadBookIds() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDocumentSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(_currentUser!.uid).get();

      if (userDocumentSnapshot.exists) {
        List<dynamic> readBooks = userDocumentSnapshot['truyen_da_doc'] ?? [];
        _readBookIds = readBooks.cast<String>();
      }

      setState(() {});
    } catch (e) {
      print('Error getting read book ids: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 32.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 9.h),
                child: Text("Lịch sử", style: CustomTextStyles.headlineSmallPoppinsBold),
              ),
              SizedBox(height: 24.v),
              _buildBookRows(context),
              SizedBox(height: 5.v),
            ],
          ),
        ),
        bottomNavigationBar: _buildHome(context),
      ),
    );
  }

  Widget _buildBookRows(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _readBookIds.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildBookRow(context, _readBookIds[index]);
        },
      ),
    );
  }

  Widget _buildBookRow(BuildContext context, String bookId) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.v),
      child: Row(
        children: [
          FutureBuilder<Widget>(
            future: _loadImage(bookId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error loading image: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return Text('No image available');
              } else {
                return Padding(
                  padding: EdgeInsets.only(right: 8.h),
                  child: snapshot.data!,
                );
              }
            },
          ),
          FutureBuilder<Map<String, dynamic>>(
            future: _getBookDetails(bookId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error loading book details: ${snapshot.error}');
              } else {
                String bookName = snapshot.data?['ten_sach'] ?? '';
                String authorName = snapshot.data?['tac_gia'] ?? '';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bookName,
                      style: theme.textTheme.labelMedium,
                    ),
                    Text(
                      "Tác giả: $authorName",
                      style: CustomTextStyles.bodySmallRegular,
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>> _getBookDetails(String bookId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> bookDocumentSnapshot =
      await FirebaseFirestore.instance.collection('sach').doc(bookId).get();

      if (bookDocumentSnapshot.exists) {
        return bookDocumentSnapshot.data() ?? {};
      }
    } catch (e) {
      print('Error getting book details for book $bookId: $e');
    }

    return {}; // Trả về một giá trị mặc định nếu không thành công
  }

  Future<Widget> _loadImage(String bookId) async {
    String path = '$bookId.jpg';

    try {
      Reference ref = FirebaseStorage.instance.ref(path);
      String downloadUrl = await ref.getDownloadURL();

      return Image.network(
        downloadUrl,
        height: 86.v,
        width: 69.h,
        fit: BoxFit.cover,
      );
    } catch (e) {
      print('Error loading image for book $bookId: $e');
      return Image.asset(
        'assets/placeholder_image.jpg',
        height: 86.v,
        width: 69.h,
        fit: BoxFit.cover,
      );
    }
  }

  Widget _buildHome(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 26.h, right: 31.h, bottom: 38.v),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              onTapHomeComponent(context);
            },
            child: Padding(
              padding: EdgeInsets.only(top: 2.v),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgHomeErrorcontainer,
                    height: 20.v,
                    width: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6.v),
                    child: Text(
                      "Trang chủ",
                      style: CustomTextStyles.bodyMediumPoppinsLight_1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(flex: 45),
          Padding(
            padding: EdgeInsets.only(bottom: 2.v),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgClockBlue300,
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                ),
                Text(
                  "Lịch sử",
                  style: CustomTextStyles.bodyMediumPoppinsBlue300,
                ),
              ],
            ),
          ),
          Spacer(flex: 54),
          GestureDetector(
            onTap: () {
              onTapBookshelfComponent(context);
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 2.v),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgBook2,
                    height: 20.adaptSize,
                    width: 20.adaptSize,
                    margin: EdgeInsets.only(left: 13.h),
                  ),
                  Text(
                    "Kệ sách",
                    style: CustomTextStyles.bodyMediumPoppinsLight_1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  onTapContinuedButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.continuedBookScreen);
  }

  onTapHomeComponent(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homeScreen);
  }

  onTapBookshelfComponent(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.bookshelfScreen);
  }
}
