import 'package:book_network_flutter/models/book/BookPageResponse.dart';
import 'package:book_network_flutter/models/book/BookResponse.dart';
import 'package:book_network_flutter/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';

class Mywaitinglistprovider with ChangeNotifier{
 final List<BookResponse> _books = [];
 bool _isLoading = false;
 bool _hasMorePage = true;
 int _page = 0;
 final int _size = 2;

 List<BookResponse> get books => _books;
 bool get isLoading => _isLoading;

 Future<void> getMyWaitingList() async{
  if(_isLoading || !_hasMorePage){
    return;
  }
  _isLoading = true;
  notifyListeners();
  try{
    final response = await bookService.getMyWaitingList(_page, _size);
    _books.addAll(response.books);
    _hasMorePage = !response.last;

    if(_hasMorePage){
      _page++;
    }

  }catch(e){
    rethrow;
  }finally{
    _isLoading = false;
    notifyListeners();
  }
 }

   Future<void> removeBook(int bookId) async {
    try {
      await bookService.removeItemFromWaitingList(bookId);
      _books.removeWhere((book) => book.id == bookId);
      notifyListeners(); 
    } catch (e) {
      print("Error removing book: $e");
    }
  }

void addBook(BookResponse book) {
  _books.add(book);
  notifyListeners();
}



}