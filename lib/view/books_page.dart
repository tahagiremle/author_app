import 'package:flutter/material.dart';

class BooksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Books Page",
        ),
      ),
      floatingActionButton: _buildAddBookFab(),
      
    );
  }

  Widget _buildAddBookFab(){
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed:_addBook,
    );
  }

  void _addBook() {
  }
}
