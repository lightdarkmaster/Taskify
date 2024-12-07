import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/pages/add_notes.dart';
import 'package:todoapp/const/const.dart';
import 'package:todoapp/pages/note_details.dart';
import 'package:todoapp/widgets/custom_drawer.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  List<Map<String, dynamic>> _notes = [];
  late Future<Database> _database;

  @override
  void initState() {
    super.initState();
    _database = _initializeDatabase();
    _fetchNotes();
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

  Future<void> _fetchNotes() async {
    final db = await _database;
    final List<Map<String, dynamic>> notes = await db.query('notes');
    setState(() {
      _notes = notes;
    });
  }

  Future<void> _deleteNote(int id) async {
    final db = await _database;
    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
    _fetchNotes(); // Refresh the note list
  }

  Future<void> _deleteAllNotes() async {
    final db = await _database;
    await db.delete('notes'); // Delete all rows from the 'notes' table
    _fetchNotes(); // Refresh the note list
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All notes deleted successfully!')),
    );
  }

  void _editNote(Map<String, dynamic> note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNotes(
          noteId: note['id'],
          title: note['title'],
          description: note['description'],
        ),
      ),
    );
    _fetchNotes(); // Refresh the note list after returning
  }

  void _navigateToAddNotes(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const AddNotes(noteId: null, title: null, description: null),
      ),
    );
    _fetchNotes(); // Refresh the task list after returning
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
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
            tooltip: 'Delete All Notes',
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Confirm Delete All', style: TextStyle(fontFamily: 'Monserat'),),
                    content: const Text(
                        'Are you sure you want to delete all notes?', style: TextStyle(fontFamily: 'Monserat'),),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel', style: TextStyle(fontFamily: 'Monserat'),),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Delete', style: TextStyle(fontFamily: 'Monserat'),),
                      ),
                    ],
                  );
                },
              );

              if (confirm == true) {
                await _deleteAllNotes();
              }
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(), // Use the custom drawer widget here
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.amber.shade200,
              Colors.lightBlueAccent.shade200,
              Colors.orange.shade100
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: _notes.isEmpty
            ? const Center(
                child: Text(
                  'No notes available. Add some notes!',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.builder(
                itemCount: _notes.length,
                itemBuilder: (context, index) {
                  final note = _notes[index];
                  final color = differentColors[index % differentColors.length];
                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: color,
                    child: Padding(
                      padding: const EdgeInsets.all(
                          8.0), // Add padding around ListTile for better spacing
                      child: ListTile(
                        isThreeLine:
                            true, // Allows up to 3 lines for the subtitle
                        leading: const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage('assets/images/icon.png'),
                        ),
                        title: Text(
                          note['title'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: 'Monserat',
                          ),
                          overflow:
                              TextOverflow.ellipsis, // Truncates long titles
                        ),
                        subtitle: Text(
                          note['description'],
                          style: const TextStyle(fontFamily: 'Monserat'),
                          overflow: TextOverflow
                              .ellipsis, // Truncates long descriptions
                          maxLines: 2, // Limit subtitle to 2 lines
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _editNote(note),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                final confirm = await showDialog<bool>(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Confirm Delete', style: TextStyle(fontFamily: 'Monserat'),),
                                      content: const Text(
                                        'Are you sure you want to delete this note?',
                                        style: TextStyle(fontFamily: 'Monserat'),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: const Text('Cancel', style: TextStyle(fontFamily: 'Monserat'),),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                          child: const Text('Delete', style: TextStyle(fontFamily: 'Monserat'),),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (confirm == true) {
                                  await _deleteNote(
                                      note['id']); // Proceed with deletion
                                }
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NoteDetailsPage(
                                note: note,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddNotes(context),
        backgroundColor: headerColor,
        tooltip: 'Add a new Notes',
        child: const Icon(Icons.add),
      ),
    );
  }
}
