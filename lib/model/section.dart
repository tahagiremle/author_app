class Section {
  int? id;
  int bookId;
  String title;
  String content;

  Section(this.bookId, this.title) : content = "";

  Section.fromMap(Map<String, dynamic> map)
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
