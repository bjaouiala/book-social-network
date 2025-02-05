import 'dart:convert';
import 'dart:io';


import 'package:book_network_flutter/exceptions/BusinessException.dart';
import 'package:book_network_flutter/models/book/BookPageResponse.dart';
import 'package:book_network_flutter/models/book/BookRequest.dart';
import 'package:book_network_flutter/models/book/BookResponse.dart';
import 'package:book_network_flutter/models/book/BookTransactionPageHistory.dart';
import 'package:book_network_flutter/services/Apis.dart';
import 'package:book_network_flutter/services/Interceptor.dart';
import 'package:book_network_flutter/services/token_service.dart';
import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:http/http.dart' as http;

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

  Future<void> removeItemFromWaitingList(int bookId) async{
    final response = await client.delete(Uri.parse("${Apis.removeItemFromWaitingList}/$bookId"));
    if(response.statusCode == 200){
      return;
    }
  }

  Future<Bookpageresponse> findMyBooks(int page, int size) async{
    final response = await client.get(Uri.parse(Apis.getBookByOwner).replace(queryParameters: {
      "page":page.toString(),
      "size":size.toString()
    }));
    if(response.statusCode == 200 ){
      return Bookpageresponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception();
    }
  }

  Future<void> borrowBook(int bookId) async{
    final response =  await client.post(Uri.parse("${Apis.borrowBook}/$bookId"));

    if(response.statusCode == 200){
      return;
    }
    if(response.statusCode == 400){
      final responseBody = jsonDecode(response.body);
      throw Businessexception(responseBody["businessErrorCode"],"error",  responseBody["error"]);
    }else{
      throw Exception();
    }
  }

  Future<void> archivedBook(int bookId) async{
    final response = await client.patch(Uri.parse("${Apis.archivedBook}/${bookId}"));
     if(response.statusCode == 200){
      return;
    }
    if(response.statusCode == 400){
      final responseBody = jsonDecode(response.body);
      throw Businessexception(responseBody["businessErrorCode"],"error",  responseBody["error"]);
    }else{
      throw Exception();
    }
  }


  Future<void> shareBook(int bookId) async{
    final response = await client.patch(Uri.parse("${Apis.shareBook}/${bookId}"));
     if(response.statusCode == 200){
      return;
    }
    if(response.statusCode == 400){
      final responseBody = jsonDecode(response.body);
      throw Businessexception(responseBody["businessErrorCode"],"error",  responseBody["error"]);
    }else{
      throw Exception();
    }
  }

  Future<void> addBook(Bookrequest request)async{
    final response = await client.post(Uri.parse(Apis.bookBaseUrl),
    body: jsonEncode(request),
    headers: {
        'content-type':'application/json'
      },);
    if(response.statusCode == 200){
      return;
    }
    
  }

  Future<Booktransactionpagehistory> getMyBorrowedBook(int page, int size)async {
    final response = await client.get(Uri.parse(Apis.borrowedBook).replace(queryParameters: {
      "page":page.toString(),
      "size":size.toString()
    }));
    if(response.statusCode == 200 ){
      return Booktransactionpagehistory.fromJson(jsonDecode(response.body));
    }else{
      throw Exception();
    }
  }

  Future<Booktransactionpagehistory> getreturnedBook(int page, int size)async {
    final response = await client.get(Uri.parse(Apis.returnedBook).replace(queryParameters: {
      "page":page.toString(),
      "size":size.toString()
    }));
    if(response.statusCode == 200 ){
      return Booktransactionpagehistory.fromJson(jsonDecode(response.body));
    }else{
      throw Exception();
    }
  }

    Future<void> returnBook(int bookId) async{
    final response = await client.patch(Uri.parse("${Apis.returnBook}/${bookId}"));
     if(response.statusCode == 200){
      return;
    }
    if(response.statusCode == 400){
      final responseBody = jsonDecode(response.body);
      throw Businessexception(responseBody["businessErrorCode"],"error",  responseBody["error"]);
    }else{
      throw Exception();
    }
  }

   Future<void> ApprouveBook(int bookId) async{
    final response = await client.patch(Uri.parse("${Apis.returnedApprouvedBook}/${bookId}"));
     if(response.statusCode == 200){
      return;
    }
    if(response.statusCode == 400){
      final responseBody = jsonDecode(response.body);
      throw Businessexception(responseBody["businessErrorCode"],"error",  responseBody["error"]);
    }else{
      throw Exception();
    }
  }

   
}

final bookService = _BookService();
