import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/presentation/admin_home_screen/admin_home_screen.dart';
import 'package:rbooks/widgets/custom_elevated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AdminhomeItemWidget extends StatelessWidget {
  AdminhomeItemWidget({
    Key? key,
    this.onTapImgImage,
    this.onTapThmChng,
    required this.bookName,
    required this.author,
    required this.productionDate,
    required this.imageUrl,
    required this.idSach,
    required this.currentUserId,
  }) : super(key: key);

  VoidCallback? onTapImgImage;
  VoidCallback? onTapThmChng;
  final String bookName;
  final String author;
  final String productionDate;
  final String imageUrl;
  final String idSach;
  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imgURL: imageUrl,
            height: 112.v,
            width: 74.h,
            radius: BorderRadius.circular(10.h),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: 7.h,
                top: 5.v,
                bottom: 10.v,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Tên sách: ",
                          style: theme.textTheme.labelLarge,
                        ),
                        TextSpan(
                          text: bookName,
                          style: CustomTextStyles.bodySmall11,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 2.v),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Tác giả: ",
                          style: theme.textTheme.labelLarge,
                        ),
                        TextSpan(
                          text: author,
                          style: CustomTextStyles.bodySmall11,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 1.v),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Xuất bản: ",
                          style: theme.textTheme.labelLarge,
                        ),
                        TextSpan(
                          text: productionDate,
                          style: CustomTextStyles.bodySmall11,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 2.v),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await onDeleteButtonPressed();
                          // Sau khi xóa, reload lại trang
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminHomeScreen()));
                        },
                        child: CustomImageView(
                          imagePath: ImageConstant.imgTrash,
                          height: 23.v,
                          width: 27.h,
                          margin: EdgeInsets.only(
                            top: 11.v,
                            bottom: 2.v,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          onTapImgImage?.call();
                        },
                        child: CustomImageView(
                          imagePath: ImageConstant.imgOffer,
                          height: 23.v,
                          width: 27.h,
                          margin: EdgeInsets.only(
                            left: 24.h,
                            top: 11.v,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(right: 5.h),
                        child: CustomElevatedButton(
                          height: 37.v,
                          width: 111.h,
                          text: " Chương",
                          buttonTextStyle: CustomTextStyles.titleSmallInter,
                          onPressed: () {
                            onTapThmChng?.call();
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onDeleteButtonPressed() async {
    try {
      // Xóa hình ảnh từ Firebase Storage
      await FirebaseStorage.instance.ref().child('$idSach.jpg').delete();

      // Xóa sách từ Firestore
      await FirebaseFirestore.instance.collection('sach').doc(idSach).delete();

      // Xóa id sách khỏi "truyen_da_doc" của người dùng
      await FirebaseFirestore.instance.collection('users').doc(currentUserId).update({
        'truyen_da_doc': FieldValue.arrayRemove([idSach]),
      });

      // Xóa id sách khỏi "truyen_yeu_thich" của người dùng
      await FirebaseFirestore.instance.collection('users').doc(currentUserId).update({
        'truyen_yeu_thich': FieldValue.arrayRemove([idSach]),
      });

    } catch (e) {
      print('Lỗi khi xóa sách: $e');
    }
  }
}