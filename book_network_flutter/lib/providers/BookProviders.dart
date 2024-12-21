import 'package:book_network_flutter/models/book/BookPageResponse.dart';
import 'package:book_network_flutter/models/book/BookResponse.dart';
import 'package:book_network_flutter/services/book_service.dart';
import 'package:flutter/material.dart';

class Bookproviders with ChangeNotifier {
  List<BookResponse> _books = [];
  bool _isLoading = false;
  bool _hasMorePage = true; 
  int _page = 0;
  final int _size = 2;

  List<BookResponse> get books => _books;
  bool get isLoading => _isLoading;


  Future<void> fetchBookss() async {
    if (_isLoading || !_hasMorePage) {
      return;
    }
    _isLoading = true;
    notifyListeners();

    try {
      final response = await bookService.getAllBooks(_page, _size); 
      _books.addAll(response.books);
      _hasMorePage = !response.last; 

      if(_hasMorePage){
        _page++;

      }

    } catch (e) {
      print("Error fetching books: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
