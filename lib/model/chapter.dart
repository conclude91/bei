class Chapter {
  final int id;
  final int idCatalogue;
  final String title;
  final String attachment;
  final String audio;

  Chapter({
    this.id,
    this.idCatalogue,
    this.title,
    this.attachment,
    this.audio,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'],
      idCatalogue: json['id_catalogue'],
      title: json['title'].toString(),
      attachment: json['attachment'].toString(),
      audio: json['audio'].toString(),
    );
  }
}
