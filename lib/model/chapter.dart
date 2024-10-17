class Chapter {
  int? id;
  int bookId;
  String title;
  String content;

  Chapter(this.bookId, this.title) : content = "";

  Chapter.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        bookId = map["bookId"],
        title = map["title"],
        content = map["content"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "bookId": bookId,
      "title": title,
      "content": content,
    };
  }
}
