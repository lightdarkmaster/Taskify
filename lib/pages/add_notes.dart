import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:todoapp/const/const.dart';

class AddNotes extends StatefulWidget {
  final int? noteId; // Optional parameter for note ID
  final String? title; // Optional parameter for title
  final String? description; // Optional parameter for description

  const AddNotes({super.key, this.noteId, this.title, this.description});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill the fields if editing
    if (widget.noteId != null) {
      _titleController.text = widget.title ?? '';
      _descriptionController.text = widget.description ?? '';
    }
  }

  Future<Database> _initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      path.join(dbPath, 'notes.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> _saveNotes() async {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields.')),
      );
      return;
    }

    final db = await _initializeDatabase();

    if (widget.noteId == null) {
      // Save new note
      await db.insert(
        'notes',
        {
          'title': title,
          'description': description,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Note saved successfully!')),
      );
    } else {
      // Update existing note
      await db.update(
        'notes',
        {
          'title': title,
          'description': description,
        },
        where: 'id = ?',
        whereArgs: [widget.noteId],
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Note updated successfully!')),
      );
    }

    Navigator.pop(context); // Navigate back to Homescreen
  }

  // Cancel button action
  void _cancel() {
    Navigator.pop(context); // Navigate back to Homescreen without saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.noteId != null ? 'Edit Note' : 'Add Note'),
        backgroundColor: headerColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.cancel),
            tooltip: 'Cancel',
            onPressed: _cancel, // Cancel action
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Note Title',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter note title',
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
                hintText: 'Enter note description',
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: _saveNotes,
                style: ElevatedButton.styleFrom(
                  backgroundColor: headerColor,
                ),
                child: Text(widget.noteId != null ? 'Update' : 'Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
