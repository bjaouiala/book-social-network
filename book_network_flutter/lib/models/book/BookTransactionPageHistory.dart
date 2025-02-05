import 'package:book_network_flutter/models/book/BookResponse.dart';
import 'package:book_network_flutter/models/book/BookTransationHistory.dart';

class Booktransactionpagehistory {
  final List<BooktransactionhistoryResponse> books;
  final int number;
  final int size;
  final int totalElements;
  final int totalPages;
  final bool first;
  final bool last;

  Booktransactionpagehistory({
    required this.books,
    required this.number,
    required this.size,
    required this.totalElements,
    required this.totalPages,
    required this.first,
    required this.last,
  });

  factory Booktransactionpagehistory.fromJson(Map<String, dynamic> json) {
    return Booktransactionpagehistory(
      books: (json['content'] as List<dynamic>?)
              ?.map((book) => BooktransactionhistoryResponse.fromJson(book))
              .toList() ??
          [],
      number: json['number'] ?? 0,
      size: json['size'] ?? 0,
      totalElements: json['totalElement'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
      first: json['first'] ?? false,
      last: json['last'] ?? false,
    );
  }
}
