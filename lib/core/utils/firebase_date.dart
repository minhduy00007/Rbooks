import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class BookData with ChangeNotifier {
  String? _bookData;

  String? get bookData => _bookData;

  void setBookId(String? bookData) {
    _bookData = bookData;
    notifyListeners();
  }

  String? _bookID;

  String? get bookID => _bookID;

  void setBookDocID(String? bookID) {
    _bookID = bookID;
    notifyListeners();
  }

  String? _chuongID;

  String? get chuongID => _chuongID;

  void setChuongID(String? chuongID) {
    _chuongID = chuongID;
    notifyListeners();
  }
}