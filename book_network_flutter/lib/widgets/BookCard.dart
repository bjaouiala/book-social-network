import 'dart:typed_data';
import 'package:book_network_flutter/models/book/BookResponse.dart';
import 'package:flutter/material.dart';

class Bookcard extends StatelessWidget {
  final BookResponse book;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onTap;
  final VoidCallback? onBorrowed; 
  final VoidCallback? onArchived;
  final VoidCallback? onShare;
  final VoidCallback? onEdit;
  final IconData? favory;
  final IconData? borrow;
  final IconData? archived;
  final IconData? shereable;
  final IconData? edit;

  const Bookcard({
    super.key,
    required this.book,
    this.onDoubleTap,
    this.onLongPress,
    this.onBorrowed,
    this.onTap,
    this.onArchived,
    this.onShare,
    this.onEdit,
    this.favory,
    this.borrow,
    this.archived,
    this.shereable,
    this.edit,



  });

  @override
  Widget build(BuildContext context) {
    Color currentBorderColor;
    if (book.shareable ) {
      currentBorderColor = Colors.green; 
    } else if (book.archived ) {
      currentBorderColor = Colors.red; 
    } else {
      currentBorderColor = Colors.black;  
    }

    return GestureDetector(
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side:  BorderSide(
            color: currentBorderColor,
            width: 2,
          ),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.person, color: Colors.red, size: 30),
                  const SizedBox(width: 4.0),
                  Text(
                    book.owner ?? 'Unknown Owner',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  child: book.cover != null
                      ? Image.memory(
                          book.cover!,
                          height: 200,
                          width: 200,
                          fit: BoxFit.contain,
                        )
                      : const Placeholder(fallbackHeight: 200, fallbackWidth: 200),
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(Icons.book, size: 18),
                  const SizedBox(width: 4.0),
                  Text(
                    book.title ?? 'Unknown Title',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Row(
                children: [
                  const Icon(Icons.code),
                  const SizedBox(width: 4.0),
                  Text(
                    book.isbn ?? 'Unknown ISBN',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Row(
                children: [
                  const Icon(Icons.person),
                  const SizedBox(width: 4.0),
                  Text(
                    book.authorName ?? 'Unknown Author',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              const Divider(thickness: 1, color: Colors.grey),
              SizedBox(
                height: 100,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    book.synopsis ?? 'No Synopsis Available',
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      height: 1.5,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (favory != null)
                    InkWell(
                      onTap: onTap,
                      child: Icon(
                        favory,
                        size: 20,
                        color: Colors.red,
                      ),
                    ),
                  if (borrow != null)
                  InkWell(
                    onTap: onBorrowed,
                    child: Icon(
                      borrow,
                      size: 20,
                      color: Colors.red,
                    ),
                  ) ,
                  if(archived != null)
                  InkWell(
                    onTap: onArchived,
                    child: Icon(
                      archived,
                      size: 20,
                      color: Colors.red,
                    ),
                  ),
                  if(shereable != null)
                  InkWell(
                    onTap: onShare,
                    child: Icon(
                      shereable,
                      size: 20,
                      color: Colors.red,
                    ),
                  ),
                  if(edit != null)
                  InkWell(
                    onTap: onEdit,
                    child: Icon(
                      edit,
                      size: 20,
                      color: Colors.red,
                    ),
                  )
                   
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



