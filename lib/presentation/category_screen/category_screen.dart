
import 'package:flutter/material.dart';
import 'package:rbooks/presentation/category_screen/widgets/twentyfive_item_widget.dart';

import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';


class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 22.h, vertical: 7.v),
                child: Column(children: [
                  SizedBox(height: 2.v),
                  _buildEleven(context),
                  Spacer(),
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 35.v,
        leadingWidth: 39.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.only(left: 9.h),
            onTap: () {
              onTapArrowLeft(context);
            }),
        centerTitle: true,
        title: AppbarTitle(text: "Thể loại"));
  }

  /// Section Widget
  Widget _buildEleven(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: FirestoreService().fetchGenresFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        List<String> genres = snapshot.data ?? [];

        return Wrap(
          runSpacing: 15.v,
          spacing: 15.h,
          children: genres
              .map((genre) => TwentyfiveItemWidget(
            genre: genre,
          ))
              .toList(),
        );
      },
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.menu);
  }
}
