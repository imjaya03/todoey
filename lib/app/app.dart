import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/app/blocs/task_bloc.dart';
import 'package:todoey/app/screens/task_list_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: TaskBloc()),
      ],
      child: MaterialApp(
        title: 'Todoey',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.pink,
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        home: TaskListScreen(),
      ),
    );
  }
}
