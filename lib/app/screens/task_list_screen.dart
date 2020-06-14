import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/app/blocs/task_bloc.dart';
import 'package:todoey/app/widgets/add_task.dart';
import 'package:todoey/app/widgets/task_item.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskBloc = Provider.of<TaskBloc>(context);
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            tooltip: 'ADD TASK',
            onPressed: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (context) {
                  return AddTask();
                },
              );
            },
            child: Icon(Icons.add),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          body: Column(
            children: <Widget>[
              _buildHeaderContainer(context, taskBloc),
              _buildTaskListContainer(taskBloc),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildTaskListContainer(TaskBloc taskBloc) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 35,
            vertical: 15,
          ),
          child: ListView.builder(
            itemCount: taskBloc.count,
            itemBuilder: (context, index) {
              return TaskItem(
                taskBloc.items[index],
              );
            },
          ),
        ),
      ),
    );
  }

  Container _buildHeaderContainer(BuildContext context, TaskBloc taskBloc) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipOval(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.list,
                      color: Theme.of(context).primaryColor, size: 40),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Todoey',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 7),
            Text(
              '${taskBloc.count} Tasks',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
