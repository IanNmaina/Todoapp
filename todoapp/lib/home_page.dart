import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
          SizedBox(height: 20), // Adding some space between input and task list
          if (_tasks.isEmpty)
            Center(
              child: Text(
                'Nothing scheduled',
                style: TextStyle(fontSize: 18),
              ),
            )
          else
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
          SizedBox(height: 20), // Adding some space between task list and message
          if (_tasks.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '${_tasks.length} task(s) remaining',
                style: TextStyle(fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }
}
