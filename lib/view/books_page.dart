import 'package:flutter/material.dart';
import 'package:flutter_author_app/model/book.dart';

class BooksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent[700],
        title: Text(
          "Books Page",
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: _buildAddBookFab(context),
    );
  }

  Widget _buildAddBookFab(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.orangeAccent[700],
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
      onPressed: () => _addBook(context),
    );
  }

  void _addBook(BuildContext context) async {
    String? bookName = await _openWindow(context);

    if (bookName != null) {
      Book newBook = Book(bookName, DateTime.now());
    }
  }

  Future<String?> _openWindow(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (context) {
        String? result;

        return AlertDialog(
          title: const Text("Enter Book Name"),
          content: TextField(
            onChanged: (newValue) {
              result = newValue;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              child: const Text("Done"),
              onPressed: () {
                Navigator.pop(context, result);
              },
            )
          ],
        );
      },
    );
  }
}
