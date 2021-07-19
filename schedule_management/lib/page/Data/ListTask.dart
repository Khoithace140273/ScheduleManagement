import 'dart:convert';
import 'package:untitled/Models/Task.dart';
import 'package:http/http.dart' as http;

class ListTask {
  Future<List<Task>> fetchTask() async {
    final response = await http.get(Uri.parse("http://localhost:8080/api/task"));
    if (response.statusCode == 200) {
      print(response.body);
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
        Uri.parse("http://localhost:8080/api/task/addtask"),
        body: {
          'done': done.toString(),
          'titleTask': titleTask,
          'reminderTime': reminderTime,
          'lastEditedTime': lastEditedTime
        },
      );
      if (!(response.statusCode == 200)) {
        throw Exception('Failed to Add Task');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> updateTask(Task task) async {
    try {
      print("asdasd");
      final response = await http.post(
        Uri.parse("http://localhost:8080/api/task/updatetask"),
        body: {
          'id': task.id,
          'done': task.done.toString(),
          'titleTask': task.titleTask,
          'reminderTime': task.reminderTime,
          'lastEditedTime': task.lastEditedTime
        },
      );
      if (!(response.statusCode == 200)) {
        throw Exception('Failed to Update Task');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> deleteTask(Task task) async {
    try {
      print("asdasd");
      final response = await http.delete(
        Uri.parse("http://localhost:8080/api/task/deletetask"),
        body: {
          'id': task.id,
          'done': task.done.toString(),
          'titleTask': task.titleTask,
          'reminderTime': task.reminderTime,
          'lastEditedTime': task.lastEditedTime
        },
      );
      if (!(response.statusCode == 200)) {
        throw Exception('Failed to Delete Task');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
