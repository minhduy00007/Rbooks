import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:rbooks/presentation/chater_list_screen/chater_list_screen.dart';

import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_text_form_field.dart';
import '../readbook_screen/readbook_screen.dart';

class BookScreen extends StatefulWidget {
  final String documentId;


  BookScreen({Key? key, required this.documentId}) : super(key: key);

  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  // Khai báo biến để theo dõi trạng thái của nút thích
  bool isFavorite = false;
  TextEditingController vnHcHCuController = TextEditingController();
  String imageUrl = "";

  @override
  void initState() {
    super.initState();
    // Gọi hàm để lấy đường dẫn hình ảnh khi StatefulWidget được khởi tạo
    getImageUrl(widget.documentId);
  }

  Future<void> getImageUrl(String documentId) async {
    try {
      final ref =
      firebase_storage.FirebaseStorage.instance.ref().child('$documentId.jpg');
      imageUrl = await ref.getDownloadURL();
      // Gọi setState để cập nhật giao diện sau khi có được URL
      setState(() {});
    } catch (e) {
      // Xử lý lỗi nếu cần
      print('Error getting image URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('sach').doc(widget.documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          var bookData = snapshot.data!.data() as Map<String, dynamic>;
          String tenSach = bookData['ten_sach'] ?? '';
          String tacGia = bookData?['tac_gia'] ?? '';
          String xuatBan = bookData?['ngay_xuat_ban'] ?? '';
          String theLoai = (bookData?['the_loai'] as List<dynamic>).join(', ');
          String luotDoc = bookData?['so_luot_doc']?.toString() ?? '';
          String luotLike = bookData?['so_luot_like'] ?? '';
          String luotRating = bookData?['so_luot_rating'] ?? '';
          String moTa = bookData?['gioi_thieu_sach'] ?? '';

          return buildBookScreen(context, tenSach, tacGia, xuatBan, theLoai, luotDoc, luotLike, luotRating, moTa);
        }
      },
    );
  }

  Widget buildBookScreen(
      BuildContext context,
      String tenSach,
      String tacGia,
      String xuatBan,
      String theLoai,
      String luotDoc,
      String luotLike,
      String luotRating,
      String moTa,
      ) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 22.v),
                _buildFour(context, tenSach, tacGia, xuatBan, luotDoc, luotLike, luotRating, theLoai),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.h,
                    vertical: 13.v,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 306.h,
                        margin: EdgeInsets.only(
                          left: 1.h,
                          right: 19.h,
                        ),
                        child: Text(
                          "Mô tả sách: ",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                      SizedBox(height: 20.v),
                      Container(
                        width: 319.h,
                        margin: EdgeInsets.only(
                          left: 1.h,
                          right: 6.h,
                        ),
                        child: Text(
                          moTa,
                          maxLines: 40,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                      SizedBox(height: 12.v),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: 1.h),
                          child: CustomIconButton(
                            height: 70.adaptSize,
                            width: 70.adaptSize,
                            padding: EdgeInsets.all(17.h),
                            decoration: IconButtonStyleHelper.fillOrange,
                            onTap: () {
                              onTapBtnButtonReadBook(context);
                            },
                            child: CustomImageView(
                              imagePath: ImageConstant.imgButtonReadBook,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.v),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFour(BuildContext context, String tenSach, String tacGia, String xuatBan, String theLoai, String luotDoc, String luotLike, String luotRating) {
    return SizedBox(
      height: 280.v,
      width: 326.h,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomAppBar(
                  leadingWidth: 40.h,
                  leading: AppbarLeadingImage(
                    imagePath: ImageConstant.imgClose,
                    margin: EdgeInsets.only(
                      left: 25.h,
                      top: 16.v,
                    ),
                    onTap: () {
                      onTapClose(context);
                    },
                  ),
                  centerTitle: true,
                  title: AppbarTitle(
                    text: tenSach.isNotEmpty ? tenSach : "",
                  ),
                ),
                SizedBox(height: 33.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgVectorErrorcontainer,
                              height: 18.adaptSize,
                              width: 18.adaptSize,
                              margin: EdgeInsets.only(bottom: 1.v),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 13.h),
                              child: Text(
                                tacGia,
                                style: CustomTextStyles.labelLargeOrange300,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3.v),
                        Padding(
                          padding: EdgeInsets.only(left: 31.h),
                          child: Text(
                            xuatBan.isNotEmpty ? xuatBan : "",
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                        SizedBox(height: 5.v),
                        CustomTextFormField(
                          width: 151.h,
                          controller: vnHcHCuController,
                          hintText: luotRating.isNotEmpty ? luotRating : "0",
                          textInputAction: TextInputAction.done,
                          alignment: Alignment.center,
                          autofocus: false,
                        ),
                        SizedBox(height: 3.v),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 150.h,
                            margin: EdgeInsets.only(
                              left: 31.h,
                              right: 22.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.imgLocation,
                                  height: 13.v,
                                  width: 15.h,
                                  margin: EdgeInsets.symmetric(vertical: 3.v),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 6.h),
                                  child: Text(
                                    luotLike.isNotEmpty ? luotLike : "0",
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ),
                                Spacer(),
                                CustomImageView(
                                  imagePath:
                                  ImageConstant.imgVectorErrorcontainer10x15,
                                  height: 10.v,
                                  width: 15.h,
                                  margin: EdgeInsets.symmetric(vertical: 4.v),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.h),
                                  child: Text(
                                    luotDoc.isNotEmpty ? luotDoc : "0",
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5.v),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(left:30.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.imgCloseSecondarycontainer,
                                  height: 14.v,
                                  width: 15.h,
                                  margin: EdgeInsets.only(bottom: 2.v),
                                ),
                                CustomImageView(
                                  imagePath: ImageConstant.imgCloseSecondarycontainer,
                                  height: 14.v,
                                  width: 15.h,
                                  margin: EdgeInsets.only(bottom: 2.v),
                                ),
                                CustomImageView(
                                  imagePath: ImageConstant.imgCloseSecondarycontainer,
                                  height: 14.v,
                                  width: 15.h,
                                  margin: EdgeInsets.only(bottom: 2.v),
                                ),
                                CustomImageView(
                                  imagePath: ImageConstant.imgCloseSecondarycontainer,
                                  height: 14.v,
                                  width: 15.h,
                                  margin: EdgeInsets.only(bottom: 2.v),
                                ),
                                CustomImageView(
                                  imagePath:
                                  ImageConstant.imgCloseSecondarycontainer14x15,
                                  height: 14.v,
                                  width: 15.h,
                                  margin: EdgeInsets.only(bottom: 2.v),
                                ),
                                CustomImageView(
                                  imagePath: ImageConstant.imgVectorErrorcontainer4x7,
                                  height: 4.v,
                                  width: 7.h,
                                  margin: EdgeInsets.only(
                                    left: 5.h,
                                    top: 5.v,
                                    bottom: 7.v,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15.h),
                                  child: Text(
                                    theLoai.isNotEmpty ? theLoai : "0",
                                    style: theme.textTheme.bodySmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 7.v),
                        GestureDetector(
                          onTap: () {
                            // Xử lý khi người dùng nhấp vào trái tim
                            onToggleFavorite();
                          },
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                            size: 40.adaptSize,
                          ),
                        ),
                      ],
                    ),
                    CustomImageView(
                      imgURL: imageUrl.isNotEmpty ? imageUrl : ImageConstant.img5,
                      height: 153.v,
                      width: 101.h,
                      radius: BorderRadius.circular(
                        10.h,
                      ),
                      margin: EdgeInsets.only(
                        top: 9.v,
                        bottom: 6.v,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateTruyenDaDoc(String userId, String documentId) async {
    try {
      // Tham chiếu đến tài liệu người dùng trong Firebase
      DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

      // Cập nhật trường "truyen_da_doc" bằng cách thêm documentId vào danh sách
      await userDoc.update({
        'truyen_da_doc': FieldValue.arrayUnion([documentId]),
      });

      print('Người dùng $userId đã đọc cuốn sách $documentId');
    } catch (e) {
      print('Lỗi khi cập nhật truyen_da_doc: $e');
    }
  }

  onTapClose(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homeScreen);
  }
  // Hàm xử lý khi người dùng nhấp vào trái tim
  void onToggleFavorite() {
    setState(() {
      // Đảo ngược trạng thái yêu thích khi người dùng nhấp vào
      isFavorite = !isFavorite;

      // Thực hiện thêm hoặc xóa ID sách khỏi danh sách yêu thích của người dùng
      toggleFavoriteBook();
    });
  }

  // Hàm thực hiện thêm hoặc xóa ID sách khỏi danh sách yêu thích của người dùng
  void toggleFavoriteBook() async {
    try {
      // Lấy thông tin về người dùng hiện tại
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Lấy ID của người dùng hiện tại
        String userId = user.uid;

        // Tham chiếu đến tài liệu người dùng trong Firebase
        DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

        if (isFavorite) {
          // Thêm ID sách vào danh sách yêu thích của người dùng
          await userDoc.update({
            'truyen_yeu_thich': FieldValue.arrayUnion([widget.documentId]),
          });

          print('Người dùng $userId đã thêm sách ${widget.documentId} vào danh sách yêu thích');
        } else {
          // Xóa ID sách khỏi danh sách yêu thích của người dùng
          await userDoc.update({
            'truyen_yeu_thich': FieldValue.arrayRemove([widget.documentId]),
          });

          print('Người dùng $userId đã xóa sách ${widget.documentId} khỏi danh sách yêu thích');
        }
      } else {
        // Người dùng không đăng nhập, xử lý theo ý bạn
        print('Người dùng chưa đăng nhập');
      }
    } catch (e) {
      print('Lỗi khi cập nhật danh sách yêu thích: $e');
    }
  }

  void onTapBtnButtonReadBook(BuildContext context) {
    try {
      // Lấy thông tin về người dùng hiện tại
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Lấy ID của người dùng hiện tại
        String userId = user.uid;

        // Cập nhật trường "truyen_da_doc" của người dùng
        updateTruyenDaDoc(userId, widget.documentId);

        // Di chuyển đến ChaterListScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChaterListScreen(documentId: widget.documentId),
          ),
        );
      } else {
        // Người dùng không đăng nhập, xử lý theo ý bạn
        print('Người dùng chưa đăng nhập');
      }
    } catch (e) {
      print('Lỗi khi lấy ID người dùng: $e');
    }
  }
}