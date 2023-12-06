import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:rbooks/presentation/book_s_chapter_add_screen/book_s_chapter_add_screen.dart';

import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_title_searchview.dart';
import '../book_s_chapter_screen/widgets/bookschapter_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/widgets/app_bar/appbar_image.dart';
import 'package:rbooks/widgets/app_bar/appbar_leading_image.dart';
import 'package:rbooks/widgets/app_bar/custom_app_bar.dart';

class ChapterInfo {
  final String tenChuong;
  final String lastUpdate;

  ChapterInfo({
    required this.tenChuong,
    required this.lastUpdate,
  });
}

Future<List<ChapterInfo>> fetchChaptersForBook(String idSach) async {
  List<ChapterInfo> chaptersInfo = [];

  print('Fetching chapters for document ID: $idSach'); // Add this line

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('chuong')
        .where('id_sach', isEqualTo: idSach)
        .get();

    List<Map<String, dynamic>> rawData = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

    rawData.sort((a, b) {
      // Convert 'last_update' strings to DateTime objects for comparison
      DateTime dateTimeA = DateFormat('dd/MM/yyyy HH:mm:ss').parse(a["last_update"]);
      DateTime dateTimeB = DateFormat('dd/MM/yyyy HH:mm:ss').parse(b["last_update"]);

      // Compare DateTime objects
      return dateTimeB.compareTo(dateTimeA);
    });

    for (var data in rawData) {
      String tenChuong = data['ten_chuong'];
      String lastUpdate = data['last_update'];

      print('Chapter Name: $tenChuong'); // Add this line

      chaptersInfo.add(ChapterInfo(
        tenChuong: tenChuong,
        lastUpdate: lastUpdate,
      ));
    }
  } catch (e) {
    print('Error fetching chapters: $e');
  }

  return chaptersInfo;
}

class BookSChapterScreen extends StatelessWidget {
  final documentId;
  const BookSChapterScreen({Key? key, required this.documentId}) : super(key: key);

  get searchController => null;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 17.h, vertical: 7.v),
                child: Column(
                  children: [
                    _buildBooksChapter(context),
                    SizedBox(height: 5.v),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10.v, // Adjust the value as needed
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 37,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to another screen when "Thêm" button is clicked
                      onTapThem(context);
                    },
                    child: Text('Thêm'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 41.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.only(left: 17.h, top: 15.v, bottom: 16.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        title: AppbarTitle(
            text: "Danh sách chương", margin: EdgeInsets.only(left: 44.h)));
  }
  /// Section Widget
  Widget _buildBooksChapter(BuildContext context) {
    return FutureBuilder<List<ChapterInfo>>(
      future: fetchChaptersForBook(documentId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<ChapterInfo> chaptersInfo = snapshot.data ?? [];

          return Container(
            height: double.maxFinite,
            child: ListView.separated(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: chaptersInfo.length,
              separatorBuilder: (context, index) => SizedBox(height: 5.v),
              itemBuilder: (context, index) {
                return BookschapterItemWidget(
                  chapterName: chaptersInfo[index].tenChuong,
                  lastUpdate: chaptersInfo[index].lastUpdate,
                );
              },
            ),
          );
        }
      },
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.adminHomeScreen);
  }

  /// Navigates to another screen when "Thêm" button is clicked.
  onTapThem(BuildContext context) {
    // Replace 'YourRouteNameHere' with the actual route name you want to navigate to
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookSChapterAddScreen(sachId: this.documentId)),
    );
  }
}