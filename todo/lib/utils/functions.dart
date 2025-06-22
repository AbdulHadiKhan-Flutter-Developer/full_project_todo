// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo/model/todo_model.dart';
import 'package:todo/utils/api.dart';

class Functions {
  // Fetch Todo Function

  Future<List<TodoModel>> fetchdata() async {
    int done = 0;
    List<TodoModel> mytodos = [];
    try {
      http.Response response = await http.get(Uri.parse(api));

      var data = jsonDecode(response.body);
      data.forEach((todo) {
        mytodos.add(TodoModel(
            id: todo['id'].toString(),
            title: todo['title'],
            description: todo['description'],
            isdone: todo['isdone']));
        if (todo['isdone']) {
          done += 1;
        }
      });
    } catch (e) {
      print('Error: $e');
    }
    return mytodos;
  }

  // Detele Todo Function

  Future<void> deletetodo(String id) async {
    try {
      http.Response response = await http.delete(Uri.parse(api + id + '/'));

      if (response.statusCode == 200) {
        print('Delete Successfully');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Post Todo Function

  Future<void> posttodo(String title, String description) async {
    try {
      http.Response response = await http.post(Uri.parse(api),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'title': title, 'description': description}));
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Post Create Successfully');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Update Todo Status

  Future<void> updatetodostatus(
      String id, String title, String description, bool isdone) async {
    try {
      final response = await http.put(
        Uri.parse(api + id + '/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': title,
          'description': description,
          'isdone': isdone,
        }),
      );

      if (response.statusCode == 200) {
        print('Update Successfully');
      } else {
        print('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
