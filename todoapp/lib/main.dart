import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for DateFormat

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

class Task {
  final String title;
  final DateTime dateTime;
  bool completed;

  Task({required this.title, required this.dateTime, this.completed = false});
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _taskController = TextEditingController();
  List<Task> _tasks = [];
  DateTime? _selectedDateTime;

  void _addTask() {
    setState(() {
      if (_taskController.text.isNotEmpty && _selectedDateTime != null) {
        _tasks.add(Task(title: _taskController.text, dateTime: _selectedDateTime!));
        _taskController.clear();
        _selectedDateTime = null;
      }
    });
  }

  void _selectDateTime() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) {
      final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (timeOfDay != null) {
        setState(() {
          _selectedDateTime = picked.add(Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute));
        });
      }
    }
  }

  void _completeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // ... rest of the code similar to before

    return Scaffold(
      // ...
      body: Column(
        children: [
          TextField(
            controller: _taskController,
            decoration: InputDecoration(
              labelText: 'Enter Task',
            ),
          ),
          ElevatedButton(
            onPressed: _selectDateTime,
            child: Text('Schedule Time'),
          ),
          ElevatedButton(
            onPressed: _addTask,
            child: Text('Add Task'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(DateFormat('yyyy-MM-dd HH:mm').format(task.dateTime)), // Display formatted date/time
                  trailing: IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () => _completeTask(index), // Call the defined method here
                  ),
                );
              },
            ),
          ),
          if (_tasks.isEmpty) // Check if there are any tasks
            Center(
              child: Text(
                'Nothing scheduled',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          else // If there are tasks, display the remaining count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '${_tasks.length}task(s) remaining',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    ),
  );
}
}