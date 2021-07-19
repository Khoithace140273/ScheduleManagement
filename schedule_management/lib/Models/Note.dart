class Note{
  String id;
  String titleNote;
  String content;
  String lastEditedTime;

  Note empty() {
    return new Note('', '', '', '');
  }
  Note(this.id, this.titleNote, this.content, this.lastEditedTime);
  factory Note.fromJson(Map<String, dynamic> json) {
    print(json['done']);
    return Note(json['idNote'], json['titleNote'],json['content'],json['dateCreate']);
  }
}