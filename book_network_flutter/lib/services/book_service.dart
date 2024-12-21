import 'dart:convert';
import 'dart:io';

import 'package:book_network_flutter/exceptions/BusinessException.dart';
import 'package:book_network_flutter/models/book/BookPageResponse.dart';
import 'package:book_network_flutter/models/book/BookResponse.dart';
import 'package:book_network_flutter/services/Apis.dart';
import 'package:book_network_flutter/services/Interceptor.dart';
import 'package:http_interceptor/http_interceptor.dart';

class _BookService {
  Future<Bookpageresponse> getAllBooks(int page,int size) async{
    final response = await client.get(Uri.parse(Apis.allBookUrl).replace(queryParameters: {
      "page": page.toString(),
      "size": size.toString()
    }));
    
      return Bookpageresponse.fromJson(jsonDecode(response.body));

  }

  Future<void> addBookToWaitingList(int id)async{
    final response = await client.post(Uri.parse("${Apis.addBookToWaitingList}$id"));
    if(response.statusCode == 200){
      return;
    }
    if(response.statusCode == 400){
      final responseBody = jsonDecode(response.body);
      throw Businessexception(responseBody["businessErrorCode"],"error", responseBody["error"]);
    }else{
      throw const SocketException("something went wrong");
    }
  }

  Future<Bookpageresponse> getMyWaitingList(int page, int size) async{
    final response = await client.get(Uri.parse(Apis.myWaitingListUrl).replace(queryParameters: {
      "page": page.toString(),
      "size" : size.toString()
    }));

    if(response.statusCode == 200){
      return Bookpageresponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception();
    }
  } 
}

final bookService = _BookService();
