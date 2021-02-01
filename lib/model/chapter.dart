class Chapter {
  final String idDetail;
  final int idCatalogue;
  final String titleChapter;
  final String attachment;
  final String audio;
  final String titleCatalogue;

  Chapter({
    this.idDetail,
    this.idCatalogue,
    this.titleChapter,
    this.attachment,
    this.audio,
    this.titleCatalogue,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      idDetail: json['id_detail'].toString(),
      idCatalogue: json['id_catalogue'],
      titleChapter: json['title'].toString(),
      attachment: json['attachment'].toString(),
      audio: json['audio'].toString(),
      titleCatalogue: json['judul_buku'].toString(),
    );
  }
}
