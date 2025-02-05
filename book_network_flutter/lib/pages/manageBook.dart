import 'package:book_network_flutter/NavigationAnimation.dart';
import 'package:book_network_flutter/helpers/CustomValidator.dart';
import 'package:book_network_flutter/helpers/helpers.dart';
import 'package:book_network_flutter/models/book/BookRequest.dart';
import 'package:book_network_flutter/pages/MyBooks.dart';
import 'package:book_network_flutter/services/book_service.dart';
import 'package:book_network_flutter/widgets/register_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Managebook extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ManageBookState();
  }
}

class ManageBookState extends State<Managebook> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  String title="";
  String isbn="";
  String synopsis="";
  String authorName="";
  bool shareable = false;

  void saveData() async{
     if(_formKey.currentState?.validate()??false){
      _formKey.currentState?.save();
    }
      Bookrequest request = Bookrequest(title, authorName, isbn, synopsis, shareable);
      try{
        await bookService.addBook(request);
        Navigator.push(context, Navigationanimation(page: Mybooks()));
        Fluttertoast.showToast(
        msg: "book added succefully",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
          webBgColor: "#00FF00", 
          webPosition: "center",
        );
      }catch (e ){
        showAlertDialog(context, "Error", "something went wrong");
      }
      
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Manage Book"),
        titleTextStyle: const TextStyle(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color.fromRGBO(96, 96, 96, 1),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30,),
                  CustomRegisterField(
                    labelText: "Title",
                    hintText: "Title",
                    icon: Icons.title,
                    validator: (value) => fieldValidators(value, "Title is mandatory"),
                    formFieldSetter: (value) => {title= value as String},
                  ),
                  const SizedBox(height: 15),
                  CustomRegisterField(
                    labelText: "Author",
                    hintText: "Author",
                    icon: Icons.person,
                    validator: (value) => fieldValidators(value, "Author name is mandatory"),
                    formFieldSetter: (value) =>{authorName= value as String}
                  ),
                  const SizedBox(height: 15),
                  CustomRegisterField(
                    labelText: "ISBN",
                    hintText: "ISBN",
                    icon: Icons.code,
                    validator: (value) => fieldValidators(value, "Isbn is mandatory"),
                    formFieldSetter: (value) =>{isbn= value as String}
                  ),
                  const SizedBox(height: 15),
                  CustomRegisterField(
                    labelText: "Synopsis",
                    hintText: "Synopsis",
                    icon: Icons.description,
                    formFieldSetter: (value) =>{synopsis= value as String}
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                        value: shareable,
                        onChanged: (bool? newValue) {
                          setState(() {
                            shareable = newValue ?? false;
                          });
                        },
                      ),
                      const Text(
                        "Share",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: 400,
                      child: ElevatedButton(
                      onPressed: ()=> saveData() , 
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                           padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
                    child: const Text("Next",style: TextStyle(color: Colors.white))))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
