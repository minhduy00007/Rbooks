import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';

// ignore: must_be_immutable
class InformationItemWidget extends StatelessWidget {
  const InformationItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 73.h,
      child: Column(
        children: [
          CustomImageView(
            imagePath: ImageConstant.img6,
            height: 112.v,
            width: 73.h,
            radius: BorderRadius.circular(
              10.h,
            ),
          ),
          SizedBox(height: 6.v),
          SizedBox(
            width: 73.h,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Dark Roads: A Novel \n",
                    style: CustomTextStyles.poppinsErrorContainerRegular,
                  ),
                  TextSpan(
                    text: "Chevy Stevens\n\n\n",
                    style: CustomTextStyles.poppinsErrorContainer,
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
