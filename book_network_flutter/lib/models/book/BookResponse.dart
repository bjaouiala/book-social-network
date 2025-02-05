import 'dart:convert';
import 'dart:typed_data';

class BookResponse {
   int? id;

   String? title;

   String? authorName;

   String? isbn;

   String? synopsis;

   String? owner;

   Uint8List? cover;

   double? rate;

   bool archived;

   bool shareable;

   BookResponse({
    this.id,
    this.title,
    this.authorName,
    this.isbn,
    this.synopsis,
    this.owner,
    this.cover,
    this.rate,
    required this.archived,
    required this.shareable
   });


  factory BookResponse.fromJson(Map<String, dynamic> json) {
  return BookResponse(
    id: json["id"],
    title: json["title"] ?? "Unknown Title",
    authorName: json["authorName"] ?? "Unknown Author",
    isbn: json["isbn"] ?? "N/A",
    synopsis: json["synopsis"] ?? "",
    owner: json["owner"] ?? "Unknown Owner",
    cover: json["cover"] != null ? base64Decode(json["cover"]) : Uint8List(0),
    rate: json["rate"] ?? 0.0,
    archived: json["archived"] ?? false,
    shareable: json["shareable"] ?? false,
  );
}

}