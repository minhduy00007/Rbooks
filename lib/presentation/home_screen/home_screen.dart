import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

import '../home_screen/widgets/atomichabitsan_item_widget.dart';
import '../home_screen/widgets/darkroadsanovel_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/widgets/app_bar/appbar_leading_circleimage.dart';
import 'package:rbooks/widgets/app_bar/appbar_title_edittext.dart';
import 'package:rbooks/widgets/app_bar/appbar_trailing_image.dart';
import 'package:rbooks/widgets/app_bar/custom_app_bar.dart';

// ignore_for_file: must_be_immutable
class FirestoreService {
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchDataFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('sach')
        .orderBy('so_luot_doc', descending: true)
        .get();

    return querySnapshot.docs;
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key,}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  Future<String> loadDisplayName() async {
    try {
      // Get the current user ID from FirebaseAuth
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId != null) {
        // Fetch user data from Firestore
        DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

        if (userSnapshot.exists) {
          String displayName = userSnapshot['ho_ten'] ?? '';
          return displayName;
        }
      }

      return 'Unknown User'; // Provide a default value if user ID is not available or data doesn't exist.
    } catch (e) {
      print('Error loading display name: $e');
      return 'Unknown User';
    }
  }
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 10.v),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFrameSixtySeven(context),
                        SizedBox(height: 12.v),
                        Padding(
                            padding: EdgeInsets.only(left: 14.h),
                            child: Row(children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 1.v),
                                  child: Text("Sách nối bật",
                                      style: theme.textTheme.titleMedium)),
                              CustomImageView(
                                  imagePath: ImageConstant.imgVector,
                                  height: 25.v,
                                  width: 18.h,
                                  margin:
                                      EdgeInsets.only(left: 24.h, bottom: 3.v))
                            ])),
                        SizedBox(height: 5.v),
                        _buildDarkRoadsANovel(context),
                        SizedBox(height: 5.v),
                        Padding(
                            padding: EdgeInsets.only(left: 14.h),
                            child: Text("Sách mới",
                                style: theme.textTheme.titleMedium)),

                        _buildAtomicHabitsAn(context),
                        SizedBox(height: 60.v),
                        _buildNinetyFour(context),
                      ]),
                ))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 70.h,
        leading: AppbarLeadingCircleimage(
            imagePath: ImageConstant.imgEllipse5,
            margin: EdgeInsets.only(left: 17.h, top: 1.v, bottom: 1.v)),
        title: FutureBuilder<String>(
          future: loadDisplayName(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Hi, Loading...',
                style: theme.textTheme.titleMedium,
              );
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}',
                style: theme.textTheme.titleMedium,
              );
            }

            String displayName = snapshot.data ?? 'Unknown User';

            return AppbarTitleEdittext(
              margin: EdgeInsets.only(left: 5.h),
              hintText: 'Hi, $displayName!',
              controller: nameController,
            );
          },
        ),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgSearch,
              margin: EdgeInsets.only(left: 25.h, top: 17.v, right: 17.h),
              onTap: () {
                onTapSearch(context);
              }),
          AppbarTrailingImage(
              imagePath: ImageConstant.imgMenu,
              margin: EdgeInsets.fromLTRB(19.h, 17.v, 42.h, 2.v),
            onTap: () {
            onTapMenu(context);
            }),
        ]);
  }

  /// Section Widget
  Widget _buildFrameSixtySeven(BuildContext context) {
    const spacing = 35.0;

    return Container(
      margin: EdgeInsets.only(left: 14.h),
      decoration: AppDecoration.fillOnPrimaryContainer,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicWidth(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (int i = 0; i < 10; i++)
                _buildRandomImageView(),
              Spacer(flex: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRandomImageView() {
    return FutureBuilder<String>(
      future: fetchRandomImageUrl(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        String imageUrl = snapshot.data ?? '';

        return CustomImageView(
          imgURL: imageUrl,
          height: 112.v,
          width: 73.v, // Đổi chiều dài thành 73.v
          radius: BorderRadius.circular(10.h),
          margin: EdgeInsets.only(bottom: 6.v, right: 20.v),
          // Thêm hành động onTap nếu cần
        );
      },
    );
  }

  Future<String> fetchRandomImageUrl() async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;

      // Lấy danh sách các document từ Firestore
      List<DocumentSnapshot> documents = await fetchDataFromFirestore();

      // Chọn ngẫu nhiên 1 document
      DocumentSnapshot randomDocument = documents[Random().nextInt(documents.length)];

      // Lấy bookId từ document
      String bookId = randomDocument.id;

      // Tạo tên ngẫu nhiên cho ảnh
      String randomImageName = '$bookId.jpg';

      // Lấy đường dẫn đến hình ảnh
      Reference ref = storage.ref().child('$randomImageName');
      String imageUrl = await ref.getDownloadURL();

      return imageUrl;
    } catch (e) {
      print('Error fetching random image URL: $e');
      return '';
    }
  }

  Widget _buildDarkRoadsANovel(BuildContext context) {
    return FutureBuilder<List<QueryDocumentSnapshot>>(
      future: FirestoreService().fetchDataFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        List<QueryDocumentSnapshot> data = snapshot.data ?? [];

        return SizedBox(
          height: 210.v,
          child: ListView.separated(
            padding: EdgeInsets.only(left: 12.h, right: 50.h),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return SizedBox(width: 21.h);
            },
            itemCount: data.length,
            itemBuilder: (context, index) {
              // Lấy ID của tài liệu Firestore
              String documentId = data[index].id;

              return DarkroadsanovelItemWidget(
                title: data[index]['ten_sach'] ?? '',
                author: data[index]['tac_gia'] ?? '',
                documentId: documentId,
              );
            },
          ),
        );
      },
    );
  }
  /// Section Widget

  Widget _buildAtomicHabitsAn(BuildContext context) {
    return FutureBuilder<List<DocumentSnapshot>>(
      future: fetchDataFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        List<DocumentSnapshot> data = snapshot.data ?? [];

        // Sắp xếp theo thứ tự last_update
        data.sort((a, b) {
          DateTime timeA = DateFormat('dd/MM/yyyy HH:mm:ss').parse(a['last_update'] as String);
          DateTime timeB = DateFormat('dd/MM/yyyy HH:mm:ss').parse(b['last_update'] as String);
          return timeB.compareTo(timeA);
        });

        return SizedBox(
          height: 210.v,
          child: ListView.separated(
            padding: EdgeInsets.only(left: 14.h),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return SizedBox(width: 32.h);
            },
            itemCount: data.length,
            itemBuilder: (context, index) {
              // Sử dụng dữ liệu từ Firestore để hiển thị thông tin sách.
              Map<String, dynamic> bookData = data[index].data() as Map<String, dynamic>;

              return AtomichabitsanItemWidget(
                title: bookData['ten_sach'] ?? '',
                author: bookData['tac_gia'] ?? '',
                documentId: data[index].id,
              );
            },
          ),
        );
      },
    );
  }
  /// Section Widget
  Widget _buildNinetyFour(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 26.h, right: 33.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              onTapHomeComponent(context);
            },
            child: Column(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgHome,
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                ),
                Text("Trang chủ", style: CustomTextStyles.bodyMediumPoppinsBlue300),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              onTapHistoryComponent(context);
            },
            child: Column(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgClock,
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                ),
                Text("Lịch sử", style: CustomTextStyles.bodyMediumPoppinsLight_1),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              onTapBookshelfComponent(context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgBook2,
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                  margin: EdgeInsets.only(left: 13.h),
                ),
                Text("Kệ sách", style: CustomTextStyles.bodyMediumPoppinsLight_1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Navigates to the searchScreen when the action is triggered.
  onTapSearch(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.searchScreen);
  }

  /// Navigates to the bookTabContainerScreen when the action is triggered.
  onTapImgFive(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.bookTabContainerScreen);
  }

  /// Navigates to the bookTabContainerScreen when the action is triggered.
  onTapBook2(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.bookTabContainerScreen);
  }

  /// Navigates to the historyScreen when the action is triggered.
  onTapHistoryComponent(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.historyScreen);
  }

  /// Navigates to the bookshelfContainerScreen when the action is triggered.
  onTapBookshelfComponent(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.bookshelfScreen);
  }
}

onTapHomeComponent(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.homeScreen);
}

onTapMenu(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.menu);
}
