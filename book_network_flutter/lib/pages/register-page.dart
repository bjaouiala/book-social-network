import 'package:book_network_flutter/helpers/CustomValidator.dart';
import 'package:book_network_flutter/helpers/helpers.dart';
import 'package:book_network_flutter/models/Auth/RegisterRequest.dart';
import 'package:book_network_flutter/services/Auth_service.dart';
import 'package:book_network_flutter/widgets/form_field_input.dart';
import 'package:book_network_flutter/widgets/register_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return RegisterState();
  }

}

class RegisterState extends State<RegisterPage>{

  final GlobalKey<FormState> _formKey = GlobalKey();
  String firstname="";
  String lastname="";
  String email ="";
  String password="";

  void register() async{
    if(_formKey.currentState?.validate()??false){
      _formKey.currentState?.save();
    }
    Registerrequest registerrequest = Registerrequest(firstname, lastname, email, password);
      try{
        if(await authService.register(registerrequest)){
          Navigator.pushNamed(context, "/activation-account");
        }
      }catch(e){
        showAlertDialog(context, "error", "something went wrong");
      }
    
    

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Register"),
        titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20),
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
      ),
      backgroundColor: const Color.fromRGBO(96, 96, 96, 1),
      body:SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(children: [
            const SizedBox(height:60),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(children: [
                 CustomRegisterField(customColor:Colors.black,
                  labelText:"Firstname",
                  hintText: "enter your Firstname",
                  icon: Icons.abc,
                  validator: (value)=>fieldValidators(value,"firstname is required"),
                  formFieldSetter: (value)=>{firstname = value as String} ,
                  ),
                  const SizedBox(height: 12),
            CustomRegisterField(customColor:Colors.black,
                  labelText:"Lastname",
                  hintText: "enter your Lastname",
                  icon: Icons.abc,
                  validator: (value)=>fieldValidators(value,"lastname is required"),
                  formFieldSetter: (value)=>{lastname = value as String} ,),
                  const SizedBox(height: 12),
            CustomRegisterField(customColor:Colors.black,
                  labelText:"Email",
                  hintText: "enter your email",
                  icon: Icons.email,
                  validator: (value)=>emailValidators(value),
                  formFieldSetter: (value)=>{email = value as String} ,),
                  const SizedBox(height: 12),
            CustomRegisterField(customColor:Colors.black,
            obscureText: true,
                  labelText:"Password",
                  hintText: "enter your Password",
                  icon: Icons.lock,
                  validator: (value)=>passwordValidator(value),
                  formFieldSetter: (value)=>{password = value as String} ,),
                  const SizedBox(height: 12),   
            SizedBox(
              width: 400,
              child: ElevatedButton(
              onPressed: register , 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text("Register",style: TextStyle(color: Colors.white))))

              ],),
              ),
           
          ],),
          
          )
        )
        ),
    );
  }

}