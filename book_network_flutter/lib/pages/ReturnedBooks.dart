import 'package:book_network_flutter/exceptions/BusinessException.dart';
import 'package:book_network_flutter/helpers/helpers.dart';
import 'package:book_network_flutter/providers/ReturnedBooks.dart';
import 'package:book_network_flutter/providers/borrowedBookProvider.dart';
import 'package:book_network_flutter/services/book_service.dart';
import 'package:book_network_flutter/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ReturnedBooks extends StatelessWidget {
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    ReturnedBookProvider bookProvider = Provider.of<ReturnedBookProvider>(context, listen: true);
    BorrowedBookProvider borrowedBookProvider = Provider.of<BorrowedBookProvider>(context, listen: true);

     WidgetsBinding.instance.addPostFrameCallback((_){
      if(bookProvider.books.isEmpty && !bookProvider.isLoading){
        bookProvider.fetchBookss();}
    });

        _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent &&
          !bookProvider.isLoading) {
        bookProvider.fetchBookss();
      }
    });

   void approuveBook(int bookId) async{
   try{
     await bookService.ApprouveBook(bookId);
     final returnedBook = bookProvider.books.firstWhere((b)=> b.id == bookId);
     bookProvider.returnBook(returnedBook);
     borrowedBookProvider.ApprouvedBook(returnedBook);

   }catch (e){
    if(e is Businessexception){
       if(e.error == "you did not borrow this book"){
          Fluttertoast.showToast(
          msg: "you did not borrow this book",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
          webBgColor: "#0000FF", 
          webPosition: "center",
          );
          
       }else if(e.error == "you cannot return the book that you are not own"){
          Fluttertoast.showToast(
          msg: "you cannot return the book that you are not own",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
          webBgColor: "#0000FF", 
          webPosition: "center",
          );
          
       }
       
       else{
        showAlertDialog(context, "Error", "something went wrong");
       }
   }

   }}

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Books"),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: SideMenu("borrowed"),
      body: bookProvider.books.isEmpty ? 
      const Center(
                child: Text(
                  "there is no returned books",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ) 
      : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: bookProvider.books.length, 
          itemBuilder: (context, index) {
            final book = bookProvider.books[index]; 

            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.code, size: 18, color: Colors.black),
                        const SizedBox(width: 8),
                        Text(
                          book.isbn,
                          style: const TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.person, size: 18, color: Colors.black),
                        const SizedBox(width: 8),
                        Text(
                          book.authorName,
                          style: const TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        const Icon(Icons.title, size: 18, color: Colors.black),
                        const SizedBox(width: 8),
                        Text(
                          book.title,
                          style: const TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),

                    IconButton(
                      onPressed: () {
                        if(!book.returnApproved){
                          approuveBook(book.id);
                        }
                      },
                      icon:  Icon(Icons.check_circle, color: book.returnApproved ? Colors.green : Colors.red),
                      tooltip: book.returned ? 'Book Returned' : 'Return Book',
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
