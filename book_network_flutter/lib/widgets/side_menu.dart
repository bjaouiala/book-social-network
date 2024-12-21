import 'package:book_network_flutter/pages/Books.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget{
  String currentRoute = "";
  @override
  Widget build(BuildContext context) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
      currentRoute = ModalRoute.of(context)?.settings.name ?? "";
      print(currentRoute);
    });

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
            Navigator.pushNamed(context, "/home");
          },
          tileColor: currentRoute == "/home" ? Colors.grey : null,
          enabled: currentRoute == "/home" ? true : false,
        )
      ],
      ),
    );
  }

}