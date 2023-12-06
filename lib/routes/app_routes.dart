import 'package:flutter/material.dart';
import 'package:rbooks/presentation/admin_menu/admin_menu.dart';
import 'package:rbooks/presentation/book_s_chapter_update_screen/book_s_chapter_update_screen.dart';
import 'package:rbooks/presentation/login_screen/login_screen.dart';
import 'package:rbooks/presentation/menu/menu.dart';
import 'package:rbooks/presentation/register_screen/register_screen.dart';
import 'package:rbooks/presentation/forget_password_screen/forget_password_screen.dart';
import 'package:rbooks/presentation/home_screen/home_screen.dart';
import 'package:rbooks/presentation/readbook_screen/readbook_screen.dart';
import 'package:rbooks/presentation/readbook_next_screen/readbook_next_screen.dart';
import 'package:rbooks/presentation/history_screen/history_screen.dart';
import 'package:rbooks/presentation/continued_book_previous_screen/continued_book_previous_screen.dart';
import 'package:rbooks/presentation/continued_book_screen/continued_book_screen.dart';
import 'package:rbooks/presentation/continued_book_next_screen/continued_book_next_screen.dart';
import 'package:rbooks/presentation/bookshelf_container_screen/bookshelf_container_screen.dart';
import 'package:rbooks/presentation/information_screen/information_screen.dart';
import 'package:rbooks/presentation/search_screen/search_screen.dart';
import 'package:rbooks/presentation/category_screen/category_screen.dart';
import 'package:rbooks/presentation/like_screen/like_screen.dart';
import 'package:rbooks/presentation/account_screen/account_screen.dart';
import 'package:rbooks/presentation/information_one_screen/information_one_screen.dart';
import 'package:rbooks/presentation/request_and_report_screen/request_and_report_screen.dart';
import 'package:rbooks/presentation/account_admin_connect_screen/account_admin_connect_screen.dart';
import 'package:rbooks/presentation/admin_home_screen/admin_home_screen.dart';
import 'package:rbooks/presentation/bookupdate_screen/bookupdate_screen.dart';
import 'package:rbooks/presentation/book_add_screen/book_add_screen.dart';
import 'package:rbooks/presentation/book_s_chapter_screen/book_s_chapter_screen.dart';
import 'package:rbooks/presentation/book_s_chapter_add_screen/book_s_chapter_add_screen.dart';
import 'package:rbooks/presentation/category_admin_screen/category_admin_screen.dart';
import 'package:rbooks/presentation/category_add_screen/category_add_screen.dart';
import 'package:rbooks/presentation/app_navigation_screen/app_navigation_screen.dart';

import '../presentation/bookshelf_screen/bookshelf_screen.dart';

class AppRoutes {
  static const String bookSChapterUpdateScreen =
      '/book_s_chapter_update_screen';

  static const String loginScreen = '/login_screen';

  static const String registerScreen = '/register_screen';

  static const String forgetPasswordScreen = '/forget_password_screen';

  static const String homeScreen = '/home_screen';

  static const String bookshelfScreen = '/bookshelf_screen';

  static const String bookPage = '/book_page';

  static const String bookTabContainerScreen = '/book_tab_container_screen';

  static const String readbookScreen = '/readbook_screen';

  static const String readbookNextScreen = '/readbook_next_screen';

  static const String historyScreen = '/history_screen';

  static const String continuedBookPreviousScreen =
      '/continued_book_previous_screen';

  static const String continuedBookScreen = '/continued_book_screen';

  static const String continuedBookNextScreen = '/continued_book_next_screen';

  static const String bookshelfPage = '/bookshelf_page';

  static const String bookshelfContainerScreen = '/bookshelf_container_screen';

  static const String informationScreen = '/information_screen';

  static const String searchScreen = '/search_screen';

  static const String categoryScreen = '/category_screen';

  static const String likeScreen = '/like_screen';

  static const String accountScreen = '/account_screen';

  static const String informationOneScreen = '/information_one_screen';

  static const String requestAndReportScreen = '/request_and_report_screen';

  static const String accountAdminConnectScreen =
      '/account_admin_connect_screen';
  static const String menu = '/menu';
  static const String adminMenu = '/admin_menu';

  static const String adminHomeScreen = '/admin_home_screen';

  static const String bookupdateScreen = '/bookupdate_screen';

  static const String bookAddScreen = '/book_add_screen';

  static const String bookSChapterScreen = '/book_s_chapter_screen';

  static const String bookSChapterAddScreen = '/book_s_chapter_add_screen';

  static const String categoryAdminScreen = '/category_admin_screen';

  static const String categoryAddScreen = '/category_add_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    loginScreen: (context) => LoginScreen(),
    registerScreen: (context) => RegisterScreen(),
    forgetPasswordScreen: (context) => ForgetPasswordScreen(),
    homeScreen: (context) => HomeScreen(),
    readbookNextScreen: (context) => ReadbookNextScreen(),
    historyScreen: (context) => HistoryScreen(),
    continuedBookPreviousScreen: (context) => ContinuedBookPreviousScreen(),
    continuedBookScreen: (context) => ContinuedBookScreen(),
    continuedBookNextScreen: (context) => ContinuedBookNextScreen(),
    bookshelfContainerScreen: (context) => BookshelfContainerScreen(),
    informationScreen: (context) => InformationScreen(),
    searchScreen: (context) => SearchScreen(),
    categoryScreen: (context) => CategoryScreen(),
    likeScreen: (context) => LikeScreen(),
    accountScreen: (context) => AccountScreen(),
    informationOneScreen: (context) => InformationOneScreen(),
    requestAndReportScreen: (context) => RequestAndReportScreen(),
    accountAdminConnectScreen: (context) => AccountAdminConnectScreen(),
    adminHomeScreen: (context) => AdminHomeScreen(),
    bookAddScreen: (context) => BookAddScreen(),
    categoryAdminScreen: (context) => CategoryAdminScreen(),
    categoryAddScreen: (context) => CategoryAddScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    bookshelfScreen: (context) => BookshelfScreen(),
    menu: (context) => Menu(),
    adminMenu: (context) => AdminMenu(),
  };
}
