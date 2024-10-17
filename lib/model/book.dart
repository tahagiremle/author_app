String bookTableName = "books";
String idField = "id";
String nameField = "name";
String dueDateField = "dueDate";

String chaptersTableName = "chapters";
String chaptersId = "id";
String chaptersBookId = "bookId";
String chaptersTitle = "title";
String chaptersContent = "content";
String chaptersDueDate = "dueDate";

class Book {
  int? id;
  String name;
  DateTime dueDate;

  Book(this.name, this.dueDate);

  Book.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        dueDate = DateTime.fromMillisecondsSinceEpoch(
          map["dueDate"],
        );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "dueDate": dueDate.millisecondsSinceEpoch,
    };
  }
}
