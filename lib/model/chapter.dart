class Chapter {
  final String idDetail;
  final int idCatalogue;
  final String title;
  final String attachment;
  final String audio;

  Chapter({
    this.idDetail,
    this.idCatalogue,
    this.title,
    this.attachment,
    this.audio,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      idDetail: json['id_detail'].toString(),
      idCatalogue: json['id_catalogue'],
      title: json['title'].toString(),
      attachment: json['attachment'].toString(),
      audio: json['audio'].toString(),
    );
  }
}
