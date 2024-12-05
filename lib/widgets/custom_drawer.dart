import 'package:flutter/material.dart';
import 'package:todoapp/pages/about_page.dart';
import 'package:todoapp/pages/display_notes.dart';
import 'package:todoapp/pages/homescreen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Drawer Header with adjustable height and text
          Container(
            height: 120.0, // Adjust the height as needed
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/header.gif'), // Replace with your image asset path
                fit: BoxFit.cover, // Ensures the image covers the entire area
              ),
            ),
            child: const Padding(
              padding:  EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Center(
                   child: Text(
                  'TODO - APP', // The text you want to display
                  style: TextStyle(
                    color: Colors.black, // Text color
                    fontSize: 40.0, // Font size
                    fontWeight: FontWeight.bold, // Bold text
                  ),
                ),
                )
              ),
            ),
          ),
          // Task ListTile with a blue background
          Container(
            color: Colors.blue.shade100, // Light blue background
            child: ListTile(
              title: const Text('Task'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Homescreen()), // Navigate to TaskPage
                );
              },
            ),
          ),
          // Notes ListTile with a green background
          Container(
            color: Colors.green.shade100, // Light green background
            child: ListTile(
              title: const Text('Notes'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NoteScreen()), // Navigate to SettingsPage
                );
              },
            ),
          ),
          // About ListTile with a red background
          Container(
            color: Colors.red.shade100, // Light red background
            child: ListTile(
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()), // Navigate to AboutPage
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
