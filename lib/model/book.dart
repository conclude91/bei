class Book {
  final int id;
  final String title;
  final String image;
  final String description;
  final String level;
  final String writer;
  final String publisher;
  final String edition;
  final String isbn;
  final String collation;
  final String attachment;
  final String group;
  final String language;
  final String subject;
  final String curiculum;
  final String status;
  final String bookType;
  final int version;
  final String type;

  Book({
    this.id,
    this.title,
    this.image,
    this.description,
    this.level,
    this.writer,
    this.publisher,
    this.edition,
    this.isbn,
    this.collation,
    this.attachment,
    this.group,
    this.language,
    this.subject,
    this.curiculum,
    this.status,
    this.bookType,
    this.version,
    this.type,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'].toString(),
      image: json['image'].toString(),
      description: json['description'].toString(),
      level: json['level'].toString(),
      writer: json['writer'].toString(),
      publisher: json['publisher'].toString(),
      edition: json['edition'].toString(),
      isbn: json['isbn'].toString(),
      collation: json['collation'].toString(),
      attachment: json['attachment'].toString(),
      group: json['class'].toString(),
      language: json['language'].toString(),
      subject: json['subject'].toString(),
      curiculum: json['curiculum'].toString(),
      status: json['status'].toString(),
      bookType: json['book_type'].toString(),
      version: json['version'],
      type: json['type'],
    );
  }

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "title": title,
  //       "image": image,
  //     };

  // List<Book> bookFromJson(String str) =>
  //     List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

  // String bookToJson(List<Book> data) =>
  //     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}
