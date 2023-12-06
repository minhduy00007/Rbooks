import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rbooks/presentation/account_admin_connect_screen/account_admin_connect_screen.dart';


import '../../routes/app_routes.dart';
import '../account_screen/account_screen.dart';
import '../category_screen/category_screen.dart';
import '../like_screen/like_screen.dart';
import '../login_screen/login_screen.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
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
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(top: 30),
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.homeScreen); // Đóng menu
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
          _buildMenuItem(Icons.account_circle, 'Tài Khoản', context),
          _buildMenuItem(Icons.favorite, 'Sách Yêu Thích', context),
          _buildMenuItem(Icons.exit_to_app, 'Đăng Xuất', context),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.homeScreen);

        // Kiểm tra mục được chọn và chuyển đến trang tương ứng
        switch (title) {
          case 'Thể Loại':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryScreen()),
            );
            break;
          case 'Tài Khoản':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccountScreen()),
            );
            break;
          case 'Sách Yêu Thích':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LikeScreen()),
            );
            break;
          case 'Đăng Xuất':
            FirebaseAuth.instance.signOut().then((value) => {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            )
            });

            break;
        }// Đóng menu
        // Xử lý khi người dùng chọn một mục trong menu
      },
      child: Container(
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