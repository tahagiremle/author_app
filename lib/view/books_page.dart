import 'package:flutter/material.dart';

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

  void _addBook(BuildContext context) {
    _openWindow(context);
  }

  void _openWindow(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter Book Name"),
          content: TextField(),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Done"),
            )
          ],
        );
      },
    );
  }
}
