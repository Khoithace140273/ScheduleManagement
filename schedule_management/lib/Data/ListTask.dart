import 'dart:convert';
import 'package:untitled/Models/Task.dart';
import 'package:http/http.dart' as http;

class ListTask {
  Future<List<Task>> fetchTask() async {
    final response = await http.get(Uri.parse("http://10.0.2.2:8080/api/task"));
    if (response.statusCode == 200) {
      return parseTasks(response.body);
    } else {
      throw Exception('Failed to load Task');
    }
  }

  List<Task> parseTasks(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Task>((json) => Task.fromJson(json)).toList();
  }

  // addTask(List<Task> tasks)  async{
  //   //final response = await http.get(Uri.parse("http://10.0.2.2:8080/api/task"));
  //   Map<int,Task> map = tasks.asMap();

  // }

  Future<dynamic> addTask(bool done, String titleTask, String reminderTime,
      String lastEditedTime) async {
    try {
      print("asdasd");
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8080/api/task/addtask"),
        body: {
          'done': done.toString(),
          'titleTask': titleTask,
          'reminderTime': reminderTime,
          'lastEditedTime': lastEditedTime
        },
      );

      print(response.statusCode);

      // return Dio().post('http://192.168.5.192:8080/api/task/addtask',
      //     data:
      //     options: Options(headers: {
      //       'Content-Type': "application/json",
      //       // 'Accept': 'application/json',
      //     }));
    } catch (e) {
      throw Exception(e);
    }
  }
}
