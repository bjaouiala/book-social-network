import 'package:flutter/material.dart';

class Navigationanimation<T> extends PageRouteBuilder<T>{
  final Widget page;

  Navigationanimation({required this.page}):super(pageBuilder: (context,animation,secondaryAnimation)=> page,
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
     print("Animation: ${animation.value}");
    const begin = Offset(1.0, 0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;
    var tween = Tween(begin: begin,end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);

    return SlideTransition(position: offsetAnimation,child: child);
  }
  );
  
}