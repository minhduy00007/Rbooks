import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    this.height,
    this.styleType,
    this.leadingWidth,
    this.leading,
    this.title,
    this.centerTitle,
    this.actions,
  }) : super(
          key: key,
        );

  final double? height;

  final Style? styleType;

  final double? leadingWidth;

  final Widget? leading;

  final Widget? title;

  final bool? centerTitle;

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: height ?? 56.v,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: _getStyle(),
      leadingWidth: leadingWidth ?? 0,
      leading: leading,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
        mediaQueryData.size.width,
        height ?? 56.v,
      );
  _getStyle() {
    switch (styleType) {
      case Style.bgFill_1:
        return Container(
          height: 46.v,
          width: 296.h,
          margin: EdgeInsets.fromLTRB(64.h, 5.v, 15.h, 5.v),
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimaryContainer,
            borderRadius: BorderRadius.circular(
              20.h,
            ),
          ),
        );
      case Style.bgFill:
        return Container(
          height: 42.v,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: appTheme.gray200,
          ),
        );
      default:
        return null;
    }
  }
}

enum Style {
  bgFill_1,
  bgFill,
}
