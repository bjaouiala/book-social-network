import 'dart:math';

import 'package:book_network_flutter/pages/ActivationAccount.dart';
import 'package:book_network_flutter/pages/Books.dart';
import 'package:book_network_flutter/pages/login-page.dart';
import 'package:book_network_flutter/pages/register-page.dart';
import 'package:book_network_flutter/providers/BookProviders.dart';
import 'package:book_network_flutter/providers/MyBooksProvider.dart';
import 'package:book_network_flutter/providers/MyWaitingListProvider.dart';
import 'package:book_network_flutter/providers/ReturnedBooks.dart';
import 'package:book_network_flutter/providers/borrowedBookProvider.dart';
import 'package:book_network_flutter/widgets/form_field_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
   MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=> Bookproviders()),
      ChangeNotifierProvider(create: (context)  => Mywaitinglistprovider()),
      ChangeNotifierProvider(create: (context)=> Mybooksprovider()),
      ChangeNotifierProvider(create: (context)=> BorrowedBookProvider()),
      ChangeNotifierProvider(create: (context)=> ReturnedBookProvider())
    ],
    child: LoginPageInit(),
    )
  );
}

class LoginPageInit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        '/register':(context) => RegisterPage(),
        '/activation-account':(context)=> ActivatioAccount(),
        '/home':(context) => Books()
      },
    );
  }
}

