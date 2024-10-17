String bookTableName = "books";
String idField = "id";
String nameField = "name";
String dueDateField = "dueDate";

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
