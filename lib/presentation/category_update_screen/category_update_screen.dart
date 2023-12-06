import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/widgets/app_bar/appbar_leading_image.dart';
import 'package:rbooks/widgets/app_bar/appbar_subtitle.dart';
import 'package:rbooks/widgets/app_bar/custom_app_bar.dart';
import 'package:rbooks/widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> getCategoryNameById(String categoryId) async {
    DocumentSnapshot documentSnapshot =
    await _firestore.collection('the_loai').doc(categoryId).get();
    return documentSnapshot.get('ten_the_loai') as String;
  }

  Future<void> updateCategory(String categoryId, String updatedCategoryName) async {
    await _firestore.collection('the_loai').doc(categoryId).update({
      'ten_the_loai': updatedCategoryName,
    });
  }
}

class CategoryUpdateScreen extends StatefulWidget {
  final String categoryId;

  const CategoryUpdateScreen({required this.categoryId, Key? key}) : super(key: key);

  @override
  _CategoryUpdateScreenState createState() => _CategoryUpdateScreenState();
}

class _CategoryUpdateScreenState extends State<CategoryUpdateScreen> {
  final TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCategoryNameAndUpdateTextField();
  }

  Future<void> _getCategoryNameAndUpdateTextField() async {
    String categoryName = await FirestoreService().getCategoryNameById(widget.categoryId);
    inputController.text = categoryName;
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 7.h, vertical: 35.v),
          child: Column(
            children: [
              _buildComponentSeventeen(context),
              Spacer(),
              SizedBox(height: 6.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomElevatedButton(
                    width: 85.h,
                    text: "Cập nhật",
                    onPressed: () {
                      onTapCapNhat(context);
                    },
                  ),
                  CustomElevatedButton(
                    width: 85.h,
                    text: "Hủy",
                    margin: EdgeInsets.only(left: 61.h),
                    buttonStyle: CustomButtonStyles.fillRedA,
                    onPressed: () {
                      onTapHuy(context);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 44.v,
      leadingWidth: 37.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeftOnprimary,
        margin: EdgeInsets.only(left: 13.h, top: 10.v, bottom: 10.v),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      centerTitle: true,
      title: AppbarSubtitle(text: "Cập nhật thể loại"),
    );
  }

  Widget _buildComponentSeventeen(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 7.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 9.v),
            child: Text("Thể loại:", style: theme.textTheme.titleSmall),
          ),
          SizedBox(width: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.h),
            child: CustomTextFormField(
              controller: inputController,
              hintText: "Nhập thể loại",
              textInputType: TextInputType.emailAddress,
              width: 250,
            ),
          ),
        ],
      ),
    );
  }

  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }

  onTapHuy(BuildContext context) {
    Navigator.pop(context);
  }

  onTapCapNhat(BuildContext context) async {
    String updatedCategoryName = inputController.text.trim();

    if (updatedCategoryName.isNotEmpty) {
      await FirestoreService().updateCategory(widget.categoryId, updatedCategoryName);
      onTapArrowLeft(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng nhập tên thể loại.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
