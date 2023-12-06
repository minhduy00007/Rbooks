import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:rbooks/core/app_export.dart';
import 'package:rbooks/presentation/book_screen/book_screen.dart';


class FirestoreService {
  Future<List<Map<String, dynamic>>> fetchBooksByGenre(String genre) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('sach')
        .where('the_loai', arrayContains: genre)
        .get();

    List<Map<String, dynamic>> books = [];

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      books.add({
        'id': doc.id,
        'ten_sach': data['ten_sach'],
        // Add more fields as needed
      });
    });

    return books;
  }
}

class CategoryBookScreen extends StatelessWidget {
  final String genre;

  const CategoryBookScreen({Key? key, required this.genre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    // Call the FirestoreService to fetch books by genre
    FirestoreService().fetchBooksByGenre(genre).then((books) {
      // Print the book information to the console
      books.forEach((book) {
        print('Book ID: ${book['id']}');
      });
    }).catchError((error) {
      // Handle any errors that occur during the fetch
      print('Error fetching books: $error');
    });

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 29.h,
            vertical: 5.v,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Xử lý khi nhấp vào mũi tên trở lại
                        Navigator.pop(context);
                      },
                      child: CustomImageView(
                        imagePath: ImageConstant.imgArrowLeft,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                        margin: EdgeInsets.only(bottom: 20.v),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 55.h,
                        top: 5.v,
                        bottom: 20.v,
                      ),
                      child: Text(
                        genre,
                        style: theme.textTheme.headlineSmall,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.v), // Adjust spacing as needed
                _buildBookImages(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookImages(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: FirestoreService().fetchBooksByGenre(genre),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error loading books: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No books available');
        } else {
          List<Map<String, dynamic>> books = snapshot.data!;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20.v,  // Increase the mainAxisSpacing to 20.v
            ),
            itemCount: books.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              String bookId = books[index]['id'];
              return _buildBookImage(context, bookId);
            },
          );
        }
      },
    );
  }

  Widget _buildBookImage(BuildContext context, String bookId) {
    return FutureBuilder<String>(
      future: _getImageUrl(bookId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error loading book image: ${snapshot.error}');
        } else {
          String imageUrl = snapshot.data!;
          return GestureDetector(
            onTap: () {
              _handleImageTap(context, bookId);
            },
            child: Column(
              children: [
                Container(
                  height: 150.v,
                  width: 100.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8.v),
              ],
            ),
          );
        }
      },
    );
  }

  // Function to handle image tap event
  void _handleImageTap(BuildContext context, String bookId) {
    // Navigate to BookScreen and pass bookId
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookScreen(documentId: bookId),
      ),
    );
  }

  Future<String> _getImageUrl(String bookId) async {
    try {
      Reference ref = FirebaseStorage.instance.ref('$bookId.jpg');
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error loading image for book $bookId: $e');
      return 'assets/placeholder_image.jpg'; // Replace with a default image
    }
  }
}