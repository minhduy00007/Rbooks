import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';

class ChipviewItemWidget extends StatelessWidget {
  final String categoryName;

  const ChipviewItemWidget({required this.categoryName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 228,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.h),
      ),
      child: RawChip(
        padding: EdgeInsets.symmetric(
          horizontal: 10.h,
          vertical: 12.v,
        ),
        showCheckmark: false,
        labelPadding: EdgeInsets.zero,
        label: Text(
          categoryName,
          style: TextStyle(
            fontSize: 15.fSize,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
        selected: false,
        backgroundColor: Colors.transparent,
        selectedColor: Colors.red, // Thay đổi màu sắc nếu cần thiết
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(
            10.h,
          ),
        ),
        onSelected: (value) {},
      ),
    );
  }
}