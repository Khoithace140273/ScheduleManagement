import 'package:untitled/Models/Note.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ListNote{
  Future<List<Note>> fetchNote() async {
    final response = await http.get(Uri.parse("http://localhost:8080/api/note"));
    if (response.statusCode == 200) {
      print(response.body);
      return parseNotes(response.body);
    } else {
      throw Exception('Failed to load Note');
    }
  }

  List<Note> parseNotes(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    print(parsed.map<Note>((json) => Note.fromJson(json)).toList());
    return parsed.map<Note>((json) => Note.fromJson(json)).toList();
  }

  // addTask(List<Note> notes)  async{
  //   //final response = await http.get(Uri.parse("http://10.0.2.2:8080/api/note"));
  //   Map<int,Note> map = notes.asMap();

  // }

  Future<dynamic> addNote( String title, String content,
      String lastEditedTime) async {
    try {
      print("asdasd");
      final response = await http.post(
        Uri.parse("http://localhost:8080/api/note/addnote"),
        body: {
          'titleNote': title,
          'content': content,
          'dateCreate': lastEditedTime
        },
      );
      if (!(response.statusCode == 200)) {
        throw Exception('Failed to Add Note');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> updateNote(Note note) async {
    try {
      print("asdasd");
      final response = await http.post(
        Uri.parse("http://localhost:8080/api/note/updatenote"),
        body: {
          'idNote': note.id,
          'titleNote': note.titleNote,
          'content': note.content,
          'dateCreate': note.lastEditedTime
        },
      );
      if (!(response.statusCode == 200)) {
        throw Exception('Failed to Update Note');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> deleteNote(Note note) async {
    try {
      print("asdasd");
      final response = await http.delete(
        Uri.parse("http://localhost:8080/api/note/deletenote"),
        body: {
          'idNote': note.id,
          'titleNote': note.titleNote,
          'content': note.content,
          'dateCreate': note.lastEditedTime
        },
      );
      if (!(response.statusCode == 200)) {
        throw Exception('Failed to Delete note');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}