import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/widgets/custom_text_form_field.dart';

// ignore: must_be_immutable
class AppbarTitleEdittext extends StatelessWidget {
  AppbarTitleEdittext({
    Key? key,
    this.hintText,
    this.controller,
    this.margin,
    this.autofocus = false,
  }) : super(
          key: key,
        );

  String? hintText;

  TextEditingController? controller;

  EdgeInsetsGeometry? margin;

  bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: CustomTextFormField(
        width: 160.h,
        controller: controller,
        hintText: hintText ?? "Hi, Kiệt Bùi!",
        hintStyle: CustomTextStyles.titleSmall15,
        borderDecoration: TextFormFieldStyleHelper.fillOrange,
        fillColor: appTheme.orange300,
        autofocus: false,
      ),
    );
  }
}
