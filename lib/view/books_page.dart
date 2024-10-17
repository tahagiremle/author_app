import 'package:flutter/material.dart';
import 'package:flutter_author_app/database/local_database.dart';
import 'package:flutter_author_app/model/book.dart';

class BooksPage extends StatefulWidget {
  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  LocalDatabase _localDatabase = LocalDatabase();

  List<Book> _books = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent[700],
        title: const Text(
          "Books Page",
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: _buildAddBookFab(context),
      body: FutureBuilder(
        future: _getAllBooks(),
        builder: _buildListView,
      ),
    );
  }

  Widget _buildListView(BuildContext context, AsyncSnapshot<void> snapshot) {
    return ListView.builder(
      itemCount: _books.length,
      itemBuilder: _buildListItem,
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(
          _books[index].id.toString(),
        ),
      ),
      title: Text(_books[index].name),
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
      int bookId = await _localDatabase.createBook(newBook);
      print("Book Id : $bookId");
      setState(() {});
    }
  }

  Future<void> _getAllBooks() async {
    _books = await _localDatabase.readAllBooks();
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
