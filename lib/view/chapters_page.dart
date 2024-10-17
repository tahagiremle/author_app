import 'package:flutter/material.dart';
import 'package:flutter_author_app/database/local_database.dart';
import 'package:flutter_author_app/model/book.dart';
import 'package:flutter_author_app/model/chapter.dart';

class ChaptersPage extends StatefulWidget {
  final Book _book;

  const ChaptersPage(this._book, {super.key});

  @override
  State<ChaptersPage> createState() => _ChaptersPageState();
}

class _ChaptersPageState extends State<ChaptersPage> {
  LocalDatabase _localDatabase = LocalDatabase();

  List<Chapter> _chapters = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent[700],
        title: Text(widget._book.name),
      ),
      floatingActionButton: _buildAddChapterFab(context),
      body: FutureBuilder(
        future: _getAllChapters(),
        builder: _buildListView,
      ),
    );
  }

  Widget _buildListView(BuildContext context, AsyncSnapshot<void> snapshot) {
    return ListView.builder(
      itemCount: _chapters.length,
      itemBuilder: _buildListItem,
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(
          _chapters[index].id.toString(),
        ),
      ),
      title: Text(_chapters[index].title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _updateChapter(context, index);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deleteChapter(index);
            },
          )
        ],
      ),
      onTap: () => _openChaptersDetailPage(context, index),
    );
  }

  Widget _buildAddChapterFab(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.orangeAccent[700],
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
      onPressed: () => _addChapter(context),
    );
  }

  void _addChapter(BuildContext context) async {
    String? chapterTitle = await _openWindow(context);
    int? bookId = widget._book.id;

    if (chapterTitle != null && bookId != null) {
      Chapter newChapter = Chapter(bookId, chapterTitle);
      int chapterId = await _localDatabase.createChapter(newChapter);
      print("Chapter Id : $chapterId");
      setState(() {});
    }
  }

  void _updateChapter(BuildContext context, int index) async {
    String? newChapterTitle = await _openWindow(context);

    if (newChapterTitle != null) {
      Chapter chapter = _chapters[index];
      chapter.title = newChapterTitle;
      int updatedLine = await _localDatabase.updateChapter(chapter);
      if (updatedLine > 0) {
        setState(() {});
      }
    }
  }

  void _deleteChapter(int index) async {
    Chapter chapter = _chapters[index];
    int deletedLine = await _localDatabase.deleteChapter(chapter);
    if (deletedLine > 0) {
      setState(() {});
    }
  }

  Future<void> _getAllChapters() async {
    int? bookId = widget._book.id;

    if (bookId != null) {
      _chapters = await _localDatabase.readAllChapters(bookId);
    }
  }

  Future<String?> _openWindow(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (context) {
        String? result;

        return AlertDialog(
          title: const Text("Enter Chapter Name"),
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

  void _openChaptersDetailPage(BuildContext content, int index) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ChaptersPage(_chapters[index]),
    //   ),
    // );
  }
}
