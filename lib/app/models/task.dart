import 'package:flutter/material.dart';

class Task with ChangeNotifier {
  final String id;
  final String title;
  bool isChacked;

  Task({@required this.id, @required this.title, this.isChacked = false});

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      isChacked: map['isChacked'] == 1,
    );
  }

  static Map<String, dynamic> toMap(Task task) {
    return {
      'id': task.id,
      'title': task.title,
      'isChacked': task.isChacked ? 1 : 0,
    };
  }
}
