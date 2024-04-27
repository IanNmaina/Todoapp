import 'package:flutter/material.dart';
import 'home_page.dart'; // Importing the home_page.dart file where MyHomePage is defined

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'My Home Page'), // Using MyHomePage widget here
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _taskController = TextEditingController();
  List<String> _tasks = [];

  void _addTask() {
    setState(() {
      String newTask = _taskController.text;
      if (newTask.isNotEmpty) {
        _tasks.add(newTask);
        _taskController.clear();
      }
    });
  }

  void _completeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          TextField(
            controller: _taskController,
            decoration: InputDecoration(
              labelText: 'Enter Task',
            ),
          ),
          ElevatedButton(
            onPressed: _addTask,
            child: Text('Add Task'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_tasks[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () => _completeTask(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
