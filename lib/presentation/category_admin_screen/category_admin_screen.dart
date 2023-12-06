import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rbooks/presentation/category_update_screen/category_update_screen.dart';

import '../category_admin_screen/widgets/chipview_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/widgets/app_bar/appbar_leading_image.dart';
import 'package:rbooks/widgets/app_bar/appbar_title.dart';
import 'package:rbooks/widgets/app_bar/custom_app_bar.dart';
import 'package:rbooks/widgets/custom_elevated_button.dart';


class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Category>> getCategoriesWithIds() async {
    QuerySnapshot querySnapshot = await _firestore.collection('the_loai').get();
    return querySnapshot.docs.map((doc) {
      return Category(
        id: doc.id,
        tenTheLoai: doc['ten_the_loai'] as String,
      );
    }).toList();
  }

  Future<void> deleteCategoryById(String categoryId) async {
    await _firestore.collection('the_loai').doc(categoryId).delete();
  }
}

class Category {
  final String id;
  final String tenTheLoai;

  Category({required this.id, required this.tenTheLoai});
}
class CategoryAdminScreen extends StatelessWidget {
  const CategoryAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 18.h),
          child: Column(
            children: [
              Expanded(
                child: _buildChipView(context),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildThm(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 39.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 9.h, top: 10.v, bottom: 10.v),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      title: AppbarTitle(
        text: "Thể loại",
        margin: EdgeInsets.only(left: 31.h),
      ),
    );
  }

  Widget _buildChipView(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: FirestoreService().getCategoriesWithIds(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Lỗi: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('Không có thể loại.');
        } else {
          return ListView.separated(
            padding: EdgeInsets.only(bottom: 60.v),
            itemCount: snapshot.data!.length,
            separatorBuilder: (context, index) => SizedBox(height: 5.v),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  onTapCategory(context, snapshot.data![index]);
                },
                child: ChipViewItemWithDelete(category: snapshot.data![index]),
              );
            },
          );
        }
      },
    );
  }

  void onTapCategory(BuildContext context, Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoryUpdateScreen(categoryId: category.id)),
    );
  }


  onTapArrowLeft(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.adminHomeScreen);
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

  onTapThm(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.categoryAddScreen);
  }
}

class ChipViewItemWithDelete extends StatelessWidget {
  final Category category;

  const ChipViewItemWithDelete({required this.category});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ChipviewItemWidget(categoryName: category.tenTheLoai),
        SizedBox(width: 10.h),
        DeleteButton(categoryId: category.id),
      ],
    );
  }
}

class DeleteButton extends StatelessWidget {
  final String categoryId;

  const DeleteButton({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDeleteConfirmationDialog(context),
      child: Container(
        width: 85.h,
        height: 41.v,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10.h),
        ),
        child: Center(
          child: Text(
            'Xóa',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận xóa'),
          content: Text('Bạn có chắc chắn muốn xóa thể loại có ID "$categoryId" không?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () async {
                await FirestoreService().deleteCategoryById(categoryId);
                Navigator.of(context).pop();
              },
              child: Text('Xác nhận'),
            ),
          ],
        );
      },
    );
  }
}