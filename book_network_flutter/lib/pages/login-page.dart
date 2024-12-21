import 'dart:io';

import 'package:book_network_flutter/NavigationAnimation.dart';
import 'package:book_network_flutter/exceptions/BusinessException.dart';
import 'package:book_network_flutter/helpers/helpers.dart';
import 'package:book_network_flutter/models/Auth/AuthenticationRequest.dart';
import 'package:book_network_flutter/models/Auth/AuthenticationResponse.dart';
import 'package:book_network_flutter/pages/Books.dart';
import 'package:book_network_flutter/pages/register-page.dart';
import 'package:book_network_flutter/services/Auth_service.dart';
import 'package:flutter/material.dart';
import 'package:book_network_flutter/widgets/form_field_input.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void login() async{
    try{
      final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
      Authenticationrequest auth = Authenticationrequest(email: email, password: password);
      Authenticationresponse authResponse = await authService.login(auth);
      Navigator.push(context, Navigationanimation(page: Books()));
      print(authResponse);
    }catch(e){
      print(e);
      if(e is Businessexception){
        if(e.businessErrorCode == 304){
          showAlertDialog(context, "error", "login or password is incorrect");
        }
      }else if(e is SocketException){
          showAlertDialog(context, "connexion error", "please verifie your connection");
        }else{
          showAlertDialog(context, "error", "Something went wrong");
        }
    }
  }


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text("Book Social Network"),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: Colors.black,
      ),
      backgroundColor: const Color.fromRGBO(96, 96, 96, 1),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(Icons.lock, size: 100, color: Colors.black),
                const SizedBox(height: 20),
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 30, color: Colors.black),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CustomTextField(
                        customColor: Colors.black,
                        labelText: "Email",
                        hintText: "Enter your email",
                        icon: Icons.person,
                        controller: emailController,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        customColor: Colors.black,
                        labelText: "Password",
                        hintText: "Enter your password",
                        icon: Icons.lock,
                        obscureText: true,
                        controller: passwordController,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, Navigationanimation(page: RegisterPage()));
                            },
                            child: const Text(
                              "Register here",
                              style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
