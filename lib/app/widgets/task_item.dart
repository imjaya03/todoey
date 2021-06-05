import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/app/blocs/task_bloc.dart';
import 'package:todoey/app/models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  TaskItem(this.task);

  @override
  Widget build(BuildContext context) {
    final taskBloc = Provider.of<TaskBloc>(context);
    return Dismissible(
      key: Key(task.id!),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Icon(
            Icons.delete,
            color: Theme.of(context).errorColor,
            size: 35,
          ),
        ),
      ),
      onDismissed: (direction) async {
        await taskBloc.delete(id: task.id);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Alert'),
              content: Text('Do you want to remove the task ?'),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text('YES')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text('NO')),
              ],
            );
          },
        );
      },
      child: CheckboxListTile(
        title: Text(
          task.title!,
          style: TextStyle(
            decoration: task.isChacked ? TextDecoration.lineThrough : null,
          ),
        ),
        onChanged: (val) async {
          await taskBloc.update(
            id: task.id,
            task: Task(
                id: task.id, title: task.title, isChacked: !task.isChacked),
          );
        },
        value: task.isChacked,
      ),
    );
  }
}
