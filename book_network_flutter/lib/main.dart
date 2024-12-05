import 'dart:math';

import 'package:book_network_flutter/pages/ActivationAccount.dart';
import 'package:book_network_flutter/pages/login-page.dart';
import 'package:book_network_flutter/pages/register-page.dart';
import 'package:book_network_flutter/widgets/form_field_input.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(LoginPageInit());
}

class LoginPageInit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        '/register':(context) => RegisterPage(),
        '/activation-account':(context)=> ActivatioAccount()
      },
    );
  }
}

