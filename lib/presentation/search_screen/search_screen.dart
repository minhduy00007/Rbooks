import '../search_screen/widgets/chipviewtwentyeight_item_widget.dart';
import '../search_screen/widgets/chipviewtwentyseven_item_widget.dart';
import '../search_screen/widgets/chipviewtwentysix_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/widgets/app_bar/appbar_leading_image.dart';
import 'package:rbooks/widgets/app_bar/appbar_title_searchview.dart';
import 'package:rbooks/widgets/app_bar/custom_app_bar.dart';

// ignore_for_file: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseSearchService {
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<List<String>> search(String query) async {
  try {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('your_books_collection') // Replace with your collection name
        .where('ten_sach', isGreaterThanOrEqualTo: query)
        .where('ten_sach', isLessThan: query + 'z')
        .get();

    return snapshot.docs.map((doc) => doc['ten_sach'] as String).toList();
  } catch (e) {
    print('Error searching books: $e');
    return [];
  }
}

Future<List<String>> getSearchSuggestions(String query) async {
  try {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('your_books_collection')
        .where('ten_sach', isGreaterThanOrEqualTo: query)
        .where('ten_sach', isLessThan: query + 'z')
        .limit(5) // Limit the number of suggestions
        .get();

    return snapshot.docs.map((doc) => doc['ten_sach'] as String).toList();
  } catch (e) {
    print('Error fetching search suggestions: $e');
    return [];
  }
}
}
class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<String> searchSuggestions = [];
  FirebaseSearchService searchService = FirebaseSearchService();
  List<String> searchResults = [];

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: SingleChildScrollView(
              child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 47.v),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 17.h),
                            child: Row(children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 1.v),
                                  child: Text("Sách nối bật",
                                      style: theme.textTheme.titleMedium)),
                              CustomImageView(
                                  imagePath: ImageConstant.imgVector,
                                  height: 25.v,
                                  width: 18.h,
                                  margin:
                                      EdgeInsets.only(left: 11.h, bottom: 3.v))
                            ])),
                        SizedBox(height: 9.v),
                        _buildChipViewTwentySeven(context),
                        SizedBox(height: 8.v),
                        Padding(
                            padding: EdgeInsets.only(left: 17.h),
                            child: Row(children: [
                              Text("Sách mới",
                                  style: theme.textTheme.titleMedium),
                              CustomImageView(
                                  imagePath: ImageConstant.imgStar,
                                  height: 24.v,
                                  width: 29.h,
                                  margin:
                                      EdgeInsets.only(left: 11.h, bottom: 2.v))
                            ])),
                        SizedBox(height: 9.v),
                        _buildChipViewTwentySix(context),
                        SizedBox(height: 18.v),
                        Padding(
                          padding: EdgeInsets.only(left: 17.h),
                          child: Row(children: [
                            Padding(
                              padding: EdgeInsets.only(top: 1.v),
                              child: Text("Kết quả tìm kiếm", style: theme.textTheme.titleMedium),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgVector,
                              height: 25.v,
                              width: 18.h,
                              margin: EdgeInsets.only(left: 14.h, bottom: 3.v),
                            ),
                          ]),
                        ),
                        SizedBox(height: 9.v),
                        Column(
                          children: searchSuggestions
                              .map((suggestion) => ListTile(
                            title: Text(suggestion),
                            // Add onTap functionality to handle suggestion selection
                            onTap: () {
                              // Handle suggestion selection (e.g., navigate to book details)
                            },
                          ))
                              .toList(),
                        ),
                      ])),
            )));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 46.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeftErrorcontainer,
        margin: EdgeInsets.only(left: 16.h, top: 10.v, bottom: 11.v),
        onTap: () {
          onTapArrowLeft(context);
        },
      ),
      title: AppbarTitleSearchview(
        margin: EdgeInsets.only(left: 8.h),
        hintText: "Search",
        controller: searchController,
        autofocus: false,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(onSearchTextChanged);
  }

  void onSearchTextChanged() async {
    String query = searchController.text;
    if (query.isEmpty) {
      setState(() {
        searchSuggestions.clear();
      });
    } else {
      List<String> suggestions =
      await searchService.getSearchSuggestions(query);
      setState(() {
        searchSuggestions = suggestions;
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

  /// Section Widget
  Widget _buildChipViewTwentySeven(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.h),
      child: FutureBuilder<List<String>>(
        future: FirestoreService2().fetchTopTenBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          List<String> topTenBooks = snapshot.data ?? [];

          return Wrap(
            runSpacing: 5.v,
            spacing: 5.h,
            children: topTenBooks
                .map((tenSach) => ChipviewtwentysevenItemWidget(
              tenSach: tenSach,
            ))
                .toList(),
          );
        },
      ),
    );
  }


  /// Section Widget
  Widget _buildChipViewTwentySix(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.h),
      child: FutureBuilder<List<String>>(
        future: FirestoreService1().fetchTopBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          List<String> topBooks = snapshot.data ?? [];

          return Wrap(
            runSpacing: 12.v,
            spacing: 12.h,
            children: topBooks
                .map((tenSach) => ChipviewtwentysixItemWidget(
              tenSach: tenSach,
            ))
                .toList(),
          );
        },
      ),
    );
  }


  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homeScreen);
  }

