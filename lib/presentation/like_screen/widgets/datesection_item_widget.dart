import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';

// ignore: must_be_immutable
class DatesectionItemWidget extends StatelessWidget {
  const DatesectionItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 11.h,
          vertical: 8.v,
        ),
        decoration: AppDecoration.fillOnPrimaryContainer.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder15,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageView(
              imagePath: ImageConstant.img686x69,
              height: 86.v,
              width: 69.h,
              radius: BorderRadius.circular(
                10.h,
              ),
              margin: EdgeInsets.only(bottom: 5.v),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 18.h,
                top: 2.v,
                bottom: 26.v,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Harry Potter - Chamber of Secrets",
                    style: theme.textTheme.labelMedium,
                  ),
                  SizedBox(height: 8.v),
                  Text(
                    "Tác giả: J. K. Rowling",
                    style: theme.textTheme.labelMedium,
                  ),
                  SizedBox(height: 8.v),
                  Text(
                    "NSX:2002",
                    style: theme.textTheme.labelMedium,
                  ),
                ],
              ),
            ),
            CustomImageView(
              imagePath: ImageConstant.imgGroup33,
              height: 24.adaptSize,
              width: 24.adaptSize,
              margin: EdgeInsets.only(
                left: 8.h,
                top: 53.v,
                bottom: 14.v,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
