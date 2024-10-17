import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_author_app/database/local_database.dart';
import 'package:flutter_author_app/model/chapter.dart';

class ChapterDetailPage extends StatelessWidget {
  final Chapter _chapter;
  LocalDatabase _localDatabase = LocalDatabase();
  TextEditingController _contentController = TextEditingController();

  ChapterDetailPage(this._chapter, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent[700],
        title: Text(_chapter.title),
        actions: [
          IconButton(
            icon: Icon(Icons.save_alt_outlined),
            onPressed: _saveContent,
          )
        ],
      ),
      body: _buildTextField(),
    );
  }

  Widget _buildTextField() {
    _contentController.text = _chapter.content;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _contentController,
        maxLines: 1000,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  void _saveContent() async {
    _chapter.content = _contentController.text;
    await _localDatabase.updateChapter(_chapter);
  }
}
