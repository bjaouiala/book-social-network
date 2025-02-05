import 'package:book_network_flutter/models/book/BookPageResponse.dart';
import 'package:book_network_flutter/models/book/BookResponse.dart';
import 'package:book_network_flutter/models/book/BookTransationHistory.dart';
import 'package:book_network_flutter/services/book_service.dart';
import 'package:flutter/material.dart';

class BorrowedBookProvider with ChangeNotifier {
  final List<BooktransactionhistoryResponse> _books = [];
  bool _isLoading = false;
  bool _hasMorePage = true; 
  int _page = 0;
  final int _size = 9;

  List<BooktransactionhistoryResponse> get books => _books;
  bool get isLoading => _isLoading;


  Future<void> fetchBookss() async {
    if (_isLoading || !_hasMorePage) {
      return;
    }
    _isLoading = true;
    notifyListeners();

    try {
      final response = await bookService.getMyBorrowedBook(_page, _size); 
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

  void returnBook(BooktransactionhistoryResponse bookTransationHistory){
    final currentTransaction = books.firstWhere((b)=> b.id == bookTransationHistory.id);
    currentTransaction.returned = true;
    notifyListeners();

  }

    void ApprouvedBook(BooktransactionhistoryResponse bookTransationHistory){
    final currentTransaction = books.firstWhere((b)=> b.id == bookTransationHistory.id);
    currentTransaction.returned = true;
    notifyListeners();

  }

  void addBook(BookResponse book){
    final currentTransatction = books.firstWhere((b)=> b.id == book.id);
    notifyListeners();
  }
}
