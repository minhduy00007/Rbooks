import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgHomeErrorcontainer,
      activeIcon: ImageConstant.imgHomeErrorcontainer,
      title: "Trang chủ",
      type: BottomBarEnum.Trangch,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgClockErrorcontainer,
      activeIcon: ImageConstant.imgClockErrorcontainer,
      title: "Lịch sử",
      type: BottomBarEnum.Lchs,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgBook2Blue300,
      activeIcon: ImageConstant.imgBook2Blue300,
      title: "Kệ sách",
      type: BottomBarEnum.Ksch,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54.v,
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: bottomMenuList[index].icon,
                  height: 30.adaptSize,
                  width: 30.adaptSize,
                  color: theme.colorScheme.errorContainer.withOpacity(1),
                ),
                Text(
                  bottomMenuList[index].title ?? "",
                  style: CustomTextStyles.bodyMediumPoppinsLight_1.copyWith(
                    color: theme.colorScheme.errorContainer.withOpacity(1),
                  ),
                ),
              ],
            ),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: bottomMenuList[index].activeIcon,
                  height: 22.v,
                  width: 20.h,
                  color: theme.colorScheme.errorContainer.withOpacity(1),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6.v),
                  child: Text(
                    bottomMenuList[index].title ?? "",
                    style: CustomTextStyles.bodyMediumPoppinsLight_1.copyWith(
                      color: theme.colorScheme.errorContainer.withOpacity(1),
                    ),
                  ),
                ),
              ],
            ),
            label: '',
          );
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}

enum BottomBarEnum {
  Trangch,
  Lchs,
  Ksch,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    this.title,
    required this.type,
  });

  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
