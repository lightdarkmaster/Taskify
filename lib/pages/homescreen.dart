import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/pages/add_task.dart';
import 'package:todoapp/const/const.dart';
import 'package:todoapp/widgets/custom_drawer.dart';
import 'package:todoapp/pages/task_details.dart';
import 'package:intl/intl.dart'; // Import intl package for date formatting
import 'dart:async'; // Import dart:async for Timer

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Map<String, dynamic>> _tasks = [];
  late Future<Database> _database;
  Timer? _timer; // Timer to periodically update date and time

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
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, timestamp TEXT)',
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text(
        'Tasks deleted successfully!',
        style: TextStyle(fontFamily: 'Monserat'),
      )),
    );
  }

  Future<void> _deleteAllTasks() async {
    final db = await _database;
    await db.delete('tasks'); // Delete all rows from the 'tasks' table
    _fetchTasks(); // Refresh the task list
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text(
        'All tasks deleted successfully!',
        style: TextStyle(fontFamily: 'Monserat'),
      )),
    );
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
        builder: (context) =>
            const AddTask(taskId: null, title: '', description: ''),
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
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Monserat'),
        ),
        backgroundColor: headerColor,
        elevation: 10,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever, color: Colors.red),
            tooltip: 'Delete All Tasks',
            onPressed: () async {
              final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        'Confirm Delete All',
                        style: TextStyle(fontFamily: 'Monserat'),
                      ),
                      content: const Text(
                        'Are you sure you want to delete all tasks?',
                        style: TextStyle(fontFamily: 'Monserat'),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontFamily: 'Monserat'),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text(
                            'Delete',
                            style: TextStyle(fontFamily: 'Monserat'),
                          ),
                        ),
                      ],
                    );
                  });

              if (confirm == true) {
                await _deleteAllTasks();
              }
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(), // Use the custom drawer widget here
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.purple.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: _tasks.isEmpty
            ? const Center(
                child: Text(
                  'No tasks available. Add some tasks!',
                  style: TextStyle(fontSize: 16, fontFamily: 'Monserat'),
                ),
              )
            : ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  final color = differentColors[index % differentColors.length];
                  final formattedTimestamp = DateFormat('yyyy-MM-dd – kk:mm')
                      .format(DateTime.parse(
                          task['timestamp'] ?? DateTime.now().toString()));
                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: color,
                    child: ListTile(
                      leading: const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/images/task.png'),
                      ),
                      title: Text(
                        task['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Monserat',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task['description'],
                            style: const TextStyle(fontFamily: 'Monserat'),
                            maxLines: 2, // Limits the subtitle to 2 lines
                            overflow: TextOverflow
                                .ellipsis, // Trims overflow with an ellipsis
                          ),
                          Text(
                            'Added on: $formattedTimestamp',
                            style: const TextStyle(
                                fontSize: 10, fontFamily: 'Monserat'),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Material(
                            shape: const CircleBorder(),
                            color: Colors.blue,
                            elevation: 4,
                            child: IconButton(
                              icon: const Icon(Icons.edit,
                                  color: Colors.white, size: 20),
                              onPressed: () => _editTask(task),
                            ),
                          ),
                          const SizedBox(
                              width: 10), // Add spacing between buttons
                          Material(
                            shape: const CircleBorder(),
                            color: Colors.red,
                            elevation: 4,
                            child: IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Colors.white, size: 20),
                              onPressed: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'Confirm Delete',
                                        style:
                                            TextStyle(fontFamily: 'Monserat'),
                                      ),
                                      content: const Text(
                                        'Are you sure you want to delete this task?',
                                        style:
                                            TextStyle(fontFamily: 'Monserat'),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(
                                                fontFamily: 'Monserat'),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                          child: const Text(
                                            'Delete',
                                            style: TextStyle(
                                                fontFamily: 'Monserat'),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (confirm == true) {
                                  await _deleteTask(
                                      task['id']); // Proceed with deletion
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskDetailsPage(task: task),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddPage(context),
        backgroundColor: headerColor,
        tooltip: 'Add a new task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
