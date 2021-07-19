import 'package:dio/dio.dart';

class ApiServices {
  ApiServices._();

  static Future<dynamic> loadTask() {
    print("Loading");
    try {
      return Dio().get(
        'http://192.168.5.192:8080/api/task',
      );
    } catch (e) {
      print("#################################: Load Task Failed");
      throw Exception('Load Task Failed');
    }
  }

  static Future<dynamic> addStorage(String id, bool done, String titleTask,
      String reminderTime, String lastEditedTime) {
    try {
      return Dio().post('http://192.168.5.192:8080/api/task/addtask',
          data: {
            'id': id,
            'done': done,
            'titleTask': titleTask,
            'reminderTime': reminderTime,
            'lastEditedTime': lastEditedTime
          },
          options: Options(headers: {
            'Content-Type': "application/json",
            // 'Accept': 'application/json',
          }));
    } catch (e) {
      throw Exception(e);
    }
  }
}
