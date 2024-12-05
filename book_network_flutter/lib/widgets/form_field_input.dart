import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget{
 final Color? customColor;
 final String? labelText;
 final String? hintText;
 final IconData? icon;
 final bool? obscureText;
 final TextEditingController? controller;


  const CustomTextField({
    this.customColor,
    this.labelText,
    this.hintText,
    this.icon,
    this.obscureText,
    this.controller,

  
  });




  @override
  Widget build(BuildContext context) {
    return   TextField(
      obscureText: obscureText ?? false,
                  cursorColor: customColor ?? Colors.black,
                  decoration: InputDecoration(
                    labelText: labelText ?? "",
                    hintText: hintText ?? "",
                    labelStyle: TextStyle(color: customColor ?? Colors.black),
                    hintStyle: TextStyle(color: customColor ?? Colors.black),
                    prefixIcon: Icon(icon ?? Icons.lock),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color:customColor ?? Colors.black, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: customColor ?? Colors.black, width: 2),
                    ),
                  ),
                  controller: controller,
                 
                );
  }

}