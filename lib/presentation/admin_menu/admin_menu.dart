import 'package:flutter/material.dart';
import 'package:rbooks/presentation/category_add_screen/category_add_screen.dart';
import 'package:rbooks/presentation/category_admin_screen/category_admin_screen.dart';


import '../../routes/app_routes.dart';
import '../account_screen/account_screen.dart';
import '../category_screen/category_screen.dart';
import '../like_screen/like_screen.dart';
import '../login_screen/login_screen.dart';

class AdminMenu extends StatefulWidget {
  @override
  _AdminMenuState createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {
  Color iconColor = Colors.black; // Màu mặc định cho icon là màu đen
  Color textColor = Colors.blue; // Màu mặc định cho chữ khi không hover

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(30),
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.adminHomeScreen); // Đóng menu
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 24), // Để giữ khoảng trắng cho icon back
              ],
            ),
          ),
          _buildMenuItem(Icons.category, 'Thể Loại', context),
          _buildMenuItem(Icons.logout, 'Đăng xuất', context),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.adminHomeScreen);

        // Kiểm tra mục được chọn và chuyển đến trang tương ứng
        switch (title) {
          case 'Thể Loại':
            Navigator.pushNamed(context, AppRoutes.categoryAdminScreen);
            break;
          case 'Đăng Xuất':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccountScreen()),
            );
            break;
        }// Đóng menu
        // Xử lý khi người dùng chọn một mục trong menu
      },
      child: Container(
        margin: EdgeInsets.only(top: 20), // Thêm khoảng trống ở đỉnh
        color: Colors.transparent, // Màu nền trong suốt để cho hover
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget dấu mũi tên về trang trước
Widget buildBackButton(BuildContext context) {
  return IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
      onTapArrowLeft(context);
    },
  );
}

void onTapArrowLeft(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.homeScreen);
}