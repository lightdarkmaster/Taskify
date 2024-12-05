import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/add_task.dart';
import 'package:todoapp/const/const.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Map<String, dynamic>> _tasks = [];
  late Future<Database> _database;

  // Define a list of colors for ListTile backgrounds
  final List<Color> _tileColors = [
    Colors.lightBlue.shade100,
    Colors.lightGreen.shade100,
    Colors.amber.shade100,
    Colors.pink.shade100,
    Colors.purple.shade100,
    Colors.orange.shade100,
    Colors.cyan.shade100,
  ];

  @override
  void initState() {
    super.initState();
    _database = _initializeDatabase();
    _fetchTasks();
  }

  Future<Database> _initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      path.join(dbPath, 'tasks.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> _fetchTasks() async {
    final db = await _database;
    final List<Map<String, dynamic>> tasks = await db.query('tasks');
    setState(() {
      _tasks = tasks;
    });
  }

  Future<void> _deleteTask(int id) async {
    final db = await _database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
    _fetchTasks(); // Refresh the task list
  }

  void _editTask(Map<String, dynamic> task) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTask(
          taskId: task['id'],
          title: task['title'],
          description: task['description'],
        ),
      ),
    );
    _fetchTasks(); // Refresh the task list after returning
  }

  void _navigateToAddPage(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddTask(taskId: null, title: null, description: null),
      ),
    );
    _fetchTasks(); // Refresh the task list after returning
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: headerColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Item',
            onPressed: () {
              _navigateToAddPage(context);
            },
          ),
        ],
        elevation: 10,
      ),
      body: _tasks.isEmpty
          ? const Center(
              child: Text(
                'No tasks available. Add some tasks!',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                final color = _tileColors[index % _tileColors.length]; // Cycle through colors
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  color: color, // Set background color of the Card
                  child: ListTile(
                    title: Text(
                      task['title'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Text(task['description']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editTask(task),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _deleteTask(task['id']);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
