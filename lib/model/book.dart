String bookTableName = "books";
String idField = "id";
String nameField = "name";
String dueDateField = "dueDate";

class Book {
  int? id;
  String name;
  DateTime dueDate;

  Book(this.name, this.dueDate);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "dueDate": dueDate,
    };
  }
}
