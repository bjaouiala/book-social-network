import 'dart:typed_data';

import 'package:book_network_flutter/exceptions/BusinessException.dart';
import 'package:book_network_flutter/helpers/helpers.dart';
import 'package:book_network_flutter/providers/BookProviders.dart';
import 'package:book_network_flutter/services/book_service.dart';
import 'package:book_network_flutter/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Books extends StatelessWidget{
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<Bookproviders>(context,listen: true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (bookProvider.books.isEmpty && !bookProvider.isLoading) {
        bookProvider.fetchBookss();
      }
    });
    scrollController.addListener((){
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent && !bookProvider.isLoading){
        bookProvider.fetchBookss();
      }
    });

    void addBookToWaitingList(int bookId) async{
      try{
        await bookService.addBookToWaitingList(bookId);
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
      drawer: SideMenu(),
      body: 
      ListView.builder(
        controller: scrollController,
        itemCount: bookProvider.books.length + (bookProvider.isLoading ? 1 : 0),
        itemBuilder: (context,index){
          if(index == bookProvider.books.length){
            return const Center(child: CircularProgressIndicator(),);
          }
          final book = bookProvider.books[index];
          return GestureDetector(
            onDoubleTap: () => {
              addBookToWaitingList(book.id as int)
            },
             child: Card(
            margin: const EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: const BorderSide(
                color: Colors.green,
                width: 1.5
              )
              
            ),
            elevation: 4,
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                     Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: Colors.red,
                        size: 30,
                        
                        ),
                      const SizedBox(width: 4.0,),
                      Text(book.owner as String, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                    ],
                  ),

                 
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child:SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: double.infinity,
                     child:  Image.memory(
                       book.cover ?? Uint8List(0),
                      height: 200,
                      width: 200,
                      fit: BoxFit.contain,
                    )
                    ),
                  ),
                  const SizedBox(height: 8.0,),
                  Row(
                    children: [
                      const Icon(Icons.book,size: 18,),
                      const SizedBox(width: 4.0,),
                      Text(
                        book.title as String,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      )
                    ],
                  ),
                  const SizedBox(height: 4.0,),
                  Row(
                    children: [
                       const Icon(Icons.code),
                       const SizedBox(width: 4.0,),
                       Text(book.isbn as String,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                    ],
                  ),
                  const SizedBox(height: 4.0,),
                  Row(
                    children: [
                      const Icon(Icons.person),
                      const SizedBox(width: 4.0),
                      Text(book.authorName as String, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
                    ],
                  ),
                  const SizedBox(height: 4.0,),
                 
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                    height: 20,
                  ),
                  SizedBox(
                    height: 100,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        book.synopsis as String,
                        style: const TextStyle(
                          fontFamily: 'Roboto', 
                          fontSize: 14,       
                          fontWeight: FontWeight.normal, 
                          height: 1.5,       
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,   
                  ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:  [
                    InkWell(
                      onTap: (){
                        addBookToWaitingList(book.id as int);
                      },
                      child: const Icon(
                      Icons.favorite,
                      size: 30,
                      color: Colors.red,
                    ),
                    ),
                    
                    Icon(
                      Icons.add_circle,
                      size: 30,
                      color: Colors.red,
                      ),
                  
                  ],
                 )

                ],
              ),
              ),
            

          )

          );
         
        },
        )
      
    );
  }

}