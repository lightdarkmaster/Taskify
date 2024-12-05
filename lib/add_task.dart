import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todoapp/const/const.dart';
import 'package:todoapp/homescreen.dart';

class AddTask extends StatefulWidget {
  final int? taskId; // Optional parameter for task ID
  final String? title; // Optional parameter for title
  final String? description; // Optional parameter for description

  const AddTask({super.key, this.taskId, this.title, this.description});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill the fields if editing
    if (widget.taskId != null) {
      _titleController.text = widget.title ?? '';
      _descriptionController.text = widget.description ?? '';
    }
  }

  Future<Database> _initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'tasks.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT)',
        );
      },
      version: 1,
    );
  }

Future<void> _saveTask() async {
  final title = _titleController.text.trim();
  final description = _descriptionController.text.trim();

  if (title.isEmpty || description.isEmpty) {
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      const SnackBar(content: Text('Please fill out all fields.')),
    );
    return;
  }

  final db = await _initializeDatabase();

  if (widget.taskId == null) {
    // Save new task
    await db.insert(
      'tasks',
      {
        'title': title,
        'description': description,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      const SnackBar(content: Text('Task saved successfully!')),
    );
  } else {
    // Update existing task
    await db.update(
      'tasks',
      {
        'title': title,
        'description': description,
      },
      where: 'id = ?',
      whereArgs: [widget.taskId],
    );
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      const SnackBar(content: Text('Task updated successfully!')),
    );
  }

  Navigator.pop(context as BuildContext); // Navigate back to Homescreen
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskId != null ? 'Edit Task' : 'Add Task'),
        backgroundColor: headerColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Task Title',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter task title',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter task description',
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: _saveTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: headerColor,
                ),
                child: Text(widget.taskId != null ? 'Update' : 'Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
