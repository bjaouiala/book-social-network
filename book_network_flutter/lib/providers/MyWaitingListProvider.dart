import 'dart:ffi';

import 'package:book_network_flutter/models/book/BookPageResponse.dart';
import 'package:book_network_flutter/models/book/BookResponse.dart';
import 'package:book_network_flutter/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';

class Mywaitinglistprovider extends ChangeNotifier{
 List<BookResponse> _books = [];
 bool _isLoading = false;
 bool _hasMorePage = true;
 int _page = 0;
 int _size = 2;

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



}