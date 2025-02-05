import 'package:book_network_flutter/models/book/BookResponse.dart';
import 'package:book_network_flutter/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';

class Mybooksprovider extends ChangeNotifier{
  final List<BookResponse> _books = [];
  bool _hasMorePage= true;
  bool _isLoading = false;
  int _page = 0 ;
  final int _size = 2;

  List<BookResponse> get books => _books;
  bool get isLoading => _isLoading;

  Future<void> getMyBooks() async{
    if(_isLoading || !_hasMorePage){
        return;
      }
      _isLoading = true;
      notifyListeners();

    try{
      final response = await bookService.findMyBooks(_page, _size);
      _books.addAll(response.books);
      _hasMorePage = !response.last;
      if(_hasMorePage){
        _page++;
      }




    }catch (e) {
      rethrow;
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  void archiveBook(BookResponse book){
    final currentBook = _books.firstWhere((b)=> b.id == book.id);
    currentBook.archived = !(currentBook.archived ?? false);
    notifyListeners();
  }

  void shareBook(BookResponse book){
   final currentBook = _books.firstWhere((b)=> b.id == book.id);
    currentBook.shareable = !(currentBook.shareable ?? false);
    notifyListeners();
  }


}