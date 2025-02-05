import 'dart:typed_data';

import 'package:book_network_flutter/exceptions/BusinessException.dart';
import 'package:book_network_flutter/helpers/helpers.dart';
import 'package:book_network_flutter/providers/BookProviders.dart';
import 'package:book_network_flutter/providers/MyWaitingListProvider.dart';
import 'package:book_network_flutter/providers/borrowedBookProvider.dart';
import 'package:book_network_flutter/services/book_service.dart';
import 'package:book_network_flutter/widgets/BookCard.dart';
import 'package:book_network_flutter/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Books extends StatelessWidget{
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
  Bookproviders  bookProvider = Provider.of<Bookproviders>(context,listen: true);
  Mywaitinglistprovider mywaitinglistprovider = Provider.of<Mywaitinglistprovider>(context,listen: false);
  BorrowedBookProvider borrowedBookProvider = Provider.of<BorrowedBookProvider>(context,listen: true);
    WidgetsBinding.instance.addPostFrameCallback((_){
    if (bookProvider.books.isEmpty && !bookProvider.isLoading) {
        bookProvider.fetchBookss();
      }
    });

     scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
          !bookProvider.isLoading) {
        bookProvider.fetchBookss();
      }
    });

    void borrowBook(int bookId)async{
      try{
        await bookService.borrowBook(bookId);
        final borrowedBook = borrowedBookProvider.books.firstWhere((b) => b.id == bookId);
        Fluttertoast.showToast(
          msg: "book borrowed succefully",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
          webBgColor: "#00FF00", 
          webPosition: "center",
          );
      }catch (e){
        print("Caught BusinessException: ${e}");
        if(e is Businessexception){
          if(e.error == "requested book cannot be borrowed since it is archived or not shareable"){
          Fluttertoast.showToast(
          msg: "requested book cannot be borrowed since it is archived or not shareable",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
          webBgColor: "#0000FF", 
          webPosition: "center",
          );
          }else if(e.error == "you cannot borrow your own book"){
          Fluttertoast.showToast(
          msg: "you cannot borrow your own book",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
          webBgColor: "#0000FF",  
          webPosition: "center",
          );
          }else if(e.error == "the request book is already borrowed"){
            
          Fluttertoast.showToast(
          msg: "the request book is already borrowed",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
          webBgColor: "#0000FF",  
          webPosition: "center",
          );
          }else{
            showAlertDialog(context, "Error", "something went wrong");
          }

        }
      }
    }

    
    void addBookToWaitingList(int bookId) async{
      try{
        await bookService.addBookToWaitingList(bookId);

        final addedBook = bookProvider.books.firstWhere((book)=> book.id == bookId);
        mywaitinglistprovider.addBook(addedBook);

        Fluttertoast.showToast(
          msg: "book added succefully",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
          webBgColor: "#00FF00", 
          webPosition: "center", 
          );
      }catch(e){
        if(e is Businessexception){
          Fluttertoast.showToast(
            msg: "the book is already in the waiting list",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0,
            webPosition: "center", 
            webBgColor: "#0000FF",
           
            );
        }else{
          showAlertDialog(context, "Error", "something went wrong");
        }
      }
    }

    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Books"),
        titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20),
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
      ),
      drawer: SideMenu("home"),
      body: bookProvider.books.isEmpty ?
      const Center(
                child: Text(
                  "there is no book posted",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ) :
      ListView.builder(
        controller: scrollController,
        itemCount: bookProvider.books.length + (bookProvider.isLoading ? 1 : 0),
        itemBuilder: (context,index){
          if(index == bookProvider.books.length){
            return const Center(child: CircularProgressIndicator(),);
          }
          final book = bookProvider.books[index];
          return Bookcard(
            book: book, 
            onDoubleTap: () => addBookToWaitingList(book.id as int),
            onTap: () => addBookToWaitingList(book.id as int),
            onBorrowed: () => borrowBook(book.id as int),
            favory: Icons.favorite,
            borrow: Icons.add_circle,
            );
          
         
        },
        )
      
    );
  }

}