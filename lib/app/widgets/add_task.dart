import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/app/blocs/task_bloc.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String _title = '';

  final _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final taskBloc = Provider.of<TaskBloc>(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  // border: OutlineInputBorder(),
                  labelText: 'Task',
                  prefixIcon: Icon(Icons.work),
                ),
                onChanged: (value) => _title = value,
                validator: (value) {
                  if (_title.isEmpty) {
                    return 'Please enter atleast 1 char';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              RaisedButton(
                onPressed: () {
                  if (_title.trim().isEmpty) return;
                  taskBloc.insert(title: _title.trim());
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  child: Text(
                    'ADD TASK'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
