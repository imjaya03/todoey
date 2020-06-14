import 'package:flutter/material.dart';
import 'package:todoey/app/models/task.dart';
import 'package:todoey/app/services/task_db_service.dart';
import 'package:uuid/uuid.dart';

class TaskBloc with ChangeNotifier {
  TaskBloc() {
    _init();
  }

  final _uuid = Uuid();
  final _taskDbService = TaskDbService.instance;

  _init() async {
    await fetchAndSetItems();
  }

  List<Task> _items = [];

  int get count => _items.length;

  List<Task> get items => [..._items];

  Future fetchAndSetItems() async {
    try {
      final fetchedItems = await _taskDbService.items();
      _items = [...fetchedItems];
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  insert({@required String title}) async {
    try {
      final newTask = Task(id: _uuid.v1(), title: title);
      await _taskDbService.insert(task: newTask);
      _items.add(newTask);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  update({@required String id, @required Task task}) async {
    try {
      final updatedTask = await _taskDbService.update(id: id, task: task);
      final findedIndex = _items.indexWhere((task) => task.id == id);
      _items[findedIndex] = updatedTask;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  delete({@required String id}) async {
    try {
      await _taskDbService.delete(id: id);
      _items.removeWhere((task) => task.id == id);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
