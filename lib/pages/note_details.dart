import 'package:flutter/material.dart';
import 'package:todoapp/const/const.dart';

class NoteDetailsPage extends StatelessWidget {
  final Map<String, dynamic> note;

  const NoteDetailsPage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Details', style: TextStyle(fontFamily: 'Monserat'),),
        backgroundColor: headerColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.only(bottom: 16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        note['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          fontFamily: 'Monserat',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Divider(
                  thickness: 1,
                ), // Added Divider here
                const SizedBox(height: 5),
                Text(
                  note['description'],
                  style: const TextStyle(fontSize: 18, fontFamily: 'Monserat'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
