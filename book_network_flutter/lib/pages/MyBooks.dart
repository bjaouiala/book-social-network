import 'package:book_network_flutter/NavigationAnimation.dart';
import 'package:book_network_flutter/exceptions/BusinessException.dart';
import 'package:book_network_flutter/helpers/helpers.dart';
import 'package:book_network_flutter/pages/manageBook.dart';
import 'package:book_network_flutter/providers/MyBooksProvider.dart';
import 'package:book_network_flutter/services/book_service.dart';
import 'package:book_network_flutter/widgets/BookCard.dart';
import 'package:book_network_flutter/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Mybooks extends StatelessWidget{
  ScrollController _scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    final Mybooksprovider mybooksprovider = Provider.of<Mybooksprovider>(context,listen: true);

    WidgetsBinding.instance.addPostFrameCallback((_){
      if(mybooksprovider.books.isEmpty&&!mybooksprovider.isLoading ){
        mybooksprovider.getMyBooks();
      }
    });

    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !mybooksprovider.isLoading){
        mybooksprovider.getMyBooks();
      }
    },);

    void archiveBook(int bookId) async{
      try{
        await bookService.archivedBook(bookId);
        final archivedBook = mybooksprovider.books.firstWhere((book)=> book.id == bookId);
        mybooksprovider.archiveBook(archivedBook);
      }catch (e){
         if(e is Businessexception){
          if(e.error == "you cannot update books archive status"){
          Fluttertoast.showToast(
          msg: "you cannot update books archive status",
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
    }}}

    void shareBook(bookId) async{
       try{
        await bookService.shareBook(bookId);
        final shareBook = mybooksprovider.books.firstWhere((book)=> book.id == bookId);
        mybooksprovider.shareBook(shareBook);
      }catch (e){
         if(e is Businessexception){
          if(e.error == "you cannot update books shareable status"){
          Fluttertoast.showToast(
          msg: "the book is archived",
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
    }}
    }



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("My Books"),
        titleTextStyle: const TextStyle(color: Colors.white),
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        actions: [
          IconButton(
            onPressed: (){ Navigator.push(context, Navigationanimation(page: Managebook()));}, icon: const Icon(Icons.add)
            )
        ],
      ),
      drawer: SideMenu("a"),
      body: mybooksprovider.books.isEmpty ?
      const Center(
        child: Text("You have no books yet", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
      ) : ListView.builder(
        controller: _scrollController,
        itemCount: mybooksprovider.books.length + (mybooksprovider.isLoading ? 1 : 0),
        itemBuilder: (context,index){
          if(index == mybooksprovider.books.length){
            return const Center(child: CircularProgressIndicator(),);
          }
          final book = mybooksprovider.books[index];
          return Bookcard(
            book: book ,
            edit: Icons.edit,
            onArchived: ()=>archiveBook(book.id as int),
            onShare: ()=> shareBook(book.id as int),
            shereable: Icons.share,
            archived: Icons.archive,
          );

        }
        
        )
    ); 
  }
}