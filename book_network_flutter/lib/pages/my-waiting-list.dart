import 'dart:typed_data';

import 'package:book_network_flutter/providers/MyWaitingListProvider.dart';
import 'package:book_network_flutter/services/book_service.dart';
import 'package:book_network_flutter/widgets/BookCard.dart';
import 'package:book_network_flutter/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


class MyWaitingList extends StatelessWidget{
    ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Mywaitinglistprovider myWaitingListProvider = Provider.of<Mywaitinglistprovider>(context,listen: true);

    WidgetsBinding.instance.addPostFrameCallback((_){
      if(myWaitingListProvider.books.isEmpty && !myWaitingListProvider.isLoading){
        myWaitingListProvider.getMyWaitingList();};
    });

      
  void removeBookFromWaitingList(int bookId) async{
    try{
      await myWaitingListProvider.removeBook(bookId);
      Fluttertoast.showToast(
        msg: "book removed succefully",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
          webBgColor: "#00FF00", 
          webPosition: "center",
        );
    }catch (e){
      Fluttertoast.showToast(
        msg: "something went wrong",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0,
            webPosition: "center", 
            webBgColor: "#0000FF",
        );
    }
  }

      
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent &&
          !myWaitingListProvider.isLoading) {
        myWaitingListProvider.getMyWaitingList();
      }
    });
  
  


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("My waiting List"),
        titleTextStyle: const TextStyle(color: Colors.white),
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
      ),
      drawer: SideMenu("waiting"),
      body:myWaitingListProvider.books.isEmpty ?
       const Center(
                child: Text(
                  "You have no books yet",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ) :

       ListView.builder(
        controller: _scrollController,
        itemCount: myWaitingListProvider.books.length + (myWaitingListProvider.isLoading ? 1 : 0) ,
        itemBuilder:(context,index){
          if(index == myWaitingListProvider.books.length){
            return const Center(child: CircularProgressIndicator(),);
          }
          final book = myWaitingListProvider.books[index];
          return Bookcard(
            book: book,
            onLongPress: (){
              showDialog(
                context: context, 
              builder: (BuildContext context){
                return  AlertDialog(
                  title: const Text("Delete Book"),
                  content: const Text('Are you sure you want to delete this book from your waiting list?'),
                  actions: [
                      TextButton(onPressed:(){ Navigator.of(context).pop();}, child: const Text("No")),
                      TextButton(onPressed: () {
                        removeBookFromWaitingList(book.id as int);
                        Navigator.of(context).pop();
                        
                        }
                        , child: const Text("yes"))
                    ]
                );
              });

              },
            borrow: Icons.add_circle,
            );
        },
        ),
    );
  }
}