import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/presentation/book_s_chapter_screen/book_s_chapter_screen.dart';
import 'package:rbooks/presentation/bookupdate_screen/bookupdate_screen.dart';
import 'package:rbooks/widgets/custom_elevated_button.dart';
import '../../widgets/app_bar/appbar_leading_circleimage.dart';
import '../../widgets/app_bar/appbar_title_edittext.dart';
import '../../widgets/app_bar/appbar_title_searchview.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../admin_home_screen/widgets/adminhome_item_widget.dart';

class BookInfo {
  final String tenSach;
  final String tacGia;
  final String ngayXuatBan;
  final String imageUrl;
  final String idSach;

  BookInfo({
    required this.tenSach,
    required this.tacGia,
    required this.ngayXuatBan,
    required this.imageUrl,
    required this.idSach,
  });
}

Future<List<BookInfo>> fetchBooksInfo() async {
  List<BookInfo> booksInfo = [];

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('sach').get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      String tenSach = doc['ten_sach'];
      String tacGia = doc['tac_gia'];
      String ngayXuatBan = doc['ngay_xuat_ban'];
      String idSach = doc.id;

      String imageUrl = await fetchBookImage(idSach);

      booksInfo.add(BookInfo(
        tenSach: tenSach,
        tacGia: tacGia,
        ngayXuatBan: ngayXuatBan,
        imageUrl: imageUrl,
        idSach: idSach,
      ));
    }
  } catch (e) {
    print('Error fetching data: $e');
  }

  return booksInfo;
}

Future<String> fetchUserName() async {
  try {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return userSnapshot.exists ? userSnapshot['ho_ten'] : 'Kiệt Bùi';
  } catch (e) {
    print('Error fetching user name: $e');
    return 'Kiệt Bùi'; // Trả về 'Kiệt Bùi' nếu có lỗi
  }
}

Future<String> fetchBookImage(String idSach) async {
  try {
    // Replace 'your_bucket_url' with the actual URL of your Firebase Storage bucket
    String imageUrl = await FirebaseStorage.instance.ref('$idSach.jpg').getDownloadURL();
    return imageUrl;
  } catch (e) {
    print('Error fetching image: $e');
    return ''; // Return an empty string if there is an error
  }
}

class AdminHomeScreen extends StatelessWidget {
  AdminHomeScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();

  get searchController => null;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 21.h, vertical: 19.v),
          child: Column(
            children: [
              SizedBox(height: 11.v),
              _buildAdminHome(context),
            ],
          ),
        ),
        bottomNavigationBar: _buildThm(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 76.h,
      leading: AppbarLeadingCircleimage(
        imagePath: ImageConstant.imgEllipse5,
        margin: EdgeInsets.only(left: 23.h, top: 1.v, bottom: 1.v),
      ),
      title: FutureBuilder<String>(
        future: fetchUserName(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            String userName = snapshot.data ?? 'Kiệt Bùi';
            return AppbarTitleEdittext(
              hintText: " $userName!",
              controller: nameController,
            );
          }
        },
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgMenu,
          margin: EdgeInsets.fromLTRB(31.h, 17.v, 31.h, 19.v),
          onTap: () {
            onTapAdminMenu(context);
          },
        )
      ],
    );
  }


  Widget _buildAdminHome(BuildContext context) {
    String currentUserId = getCurrentUserId();
    return FutureBuilder<List<BookInfo>>(
      future: fetchBooksInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<BookInfo> booksInfo = snapshot.data ?? [];

          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 9.h),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(booksInfo.length, (index) {
                    return Column(
                      children: [
                        AdminhomeItemWidget(
                          onTapImgImage: () {
                            onTapImgImage(context, booksInfo[index].idSach);
                          },
                          onTapThmChng: () {
                            onTapThmChng(context, booksInfo[index].idSach);
                          },
                          bookName: booksInfo[index].tenSach,
                          author: booksInfo[index].tacGia,
                          productionDate: booksInfo[index].ngayXuatBan,
                          imageUrl: booksInfo[index].imageUrl,
                          idSach: booksInfo[index].idSach, currentUserId: currentUserId,
                        ),
                        SizedBox(height: 6.v),
                      ],
                    );
                  }),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildThm(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 80.h, right: 83.h),
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: CustomElevatedButton(
        height: 37.v,
        width: 212.h,
        text: "Thêm",
        buttonStyle: CustomButtonStyles.fillPrimary,
        buttonTextStyle: CustomTextStyles.titleSmallInter,
        onPressed: () {
          onTapThm(context);
        },
      ),
    );
  }

  onTapImgImage(BuildContext context, String idSach) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookupdateScreen(documentId: idSach)),
    );
  }

  onTapThmChng(BuildContext context, String idSach) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookSChapterScreen(documentId: idSach)),
    );
  }

  onTapThm(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.bookAddScreen);
  }

  onTapAdminMenu(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.adminMenu);
  }

  String getCurrentUserId() {
    // Lấy thông tin người dùng hiện tại từ Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;

    // Kiểm tra xem người dùng có đăng nhập hay không
    if (user != null) {
      // Trả về ID của người dùng nếu đã đăng nhập
      return user.uid;
    } else {
      // Nếu người dùng chưa đăng nhập, có thể trả về một giá trị mặc định hoặc xử lý theo nhu cầu của bạn
      return 'default_user_id';
    }
  }
}
