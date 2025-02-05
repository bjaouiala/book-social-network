import 'dart:typed_data';

import 'package:http_interceptor/http_interceptor.dart';

class Bookrequest {
   String title;

   String authorName;

   String isbn;

   String synopsis;

   bool shareable;

   Bookrequest(
    this.title,
    this.authorName,
    this.isbn,
    this.synopsis,
    this.shareable);

   Map<String,dynamic> toJson(){
    return{
      "title":title,
      "authorName":authorName,
      "isbn":isbn,
      "synopsis":synopsis,
      "shareable":shareable
    };
   }
}