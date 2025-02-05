import 'package:book_network_flutter/NavigationAnimation.dart';
import 'package:book_network_flutter/pages/Books.dart';
import 'package:book_network_flutter/pages/BorrowedBooks.dart';
import 'package:book_network_flutter/pages/MyBooks.dart';
import 'package:book_network_flutter/pages/ReturnedBooks.dart';
import 'package:book_network_flutter/pages/login-page.dart';
import 'package:book_network_flutter/pages/my-waiting-list.dart';
import 'package:book_network_flutter/services/token_service.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget{
  String currentRoute = "";
  
  SideMenu(String route){
    this.currentRoute = route;
  }

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
      children:  [
          const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.black
          ),
          child: Text("Menu",style: TextStyle(color: Colors.white,),
        )
        ),
        ListTile(
          title: const Text("Books",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          leading: const Icon(Icons.home),
          onTap: (){
            Navigator.pop(context);
            Navigator.pushReplacement(context, Navigationanimation(page:  Books()));
          },

        ),
        ListTile(
          title: const Text("My waiting List", style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),),
          leading: const Icon(Icons.favorite),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(context, Navigationanimation(page: MyWaitingList()));
          },
        ),
        ListTile(
          title: const Text("My books" ,style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),),
          leading: const Icon(Icons.book),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(context, Navigationanimation(page: Mybooks()));
          },
        ),
        ListTile(
          title: const Text("My Borrowed books" ,style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),),
          leading: const Icon(Icons.book),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(context, Navigationanimation(page: Borrowedbooks()));
          },
        ),
         ListTile(
          title: const Text("My Returned books" ,style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),),
          leading: const Icon(Icons.book),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacement(context, Navigationanimation(page: ReturnedBooks()));
          },
        ),
        const SizedBox(height: 20,),
        ListTile(
          title: const Text("Logout" ,style: TextStyle(color: Colors.black,fontWeight:FontWeight.bold),),
          leading: const Icon(Icons.logout),
          onTap: () {
            tokenService.removeToken();
            Navigator.pop(context);
            Navigator.pushReplacement(context, Navigationanimation(page: LoginPage()));
          },
        )
      ],
      ),
    );
  }

}