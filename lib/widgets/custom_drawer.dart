import 'package:flutter/material.dart';
import 'package:todoapp/pages/about_page.dart';
import 'package:todoapp/pages/display_notes.dart';
import 'package:todoapp/pages/homescreen.dart';
import 'package:todoapp/pages/user_manual.dart';

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
                image: AssetImage(
                    'assets/images/header.gif'), // Replace with your image asset path
                fit: BoxFit.cover, // Ensures the image covers the entire area
              ),
            ),
          ),
          // Task ListTile with a blue background and an image icon
          Container(
            color: Colors.blue.shade100, // Light blue background
            child: ListTile(
              leading: Image.asset(
                'assets/images/taskicon.png', // Replace with your image asset path for Task
                width: 30.0,
                height: 30.0,
              ),
              title: const Text('Task', style: TextStyle(fontFamily: 'Monserat'),),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const Homescreen()), // Navigate to TaskPage
                );
              },
            ),
          ),
          // Notes ListTile with a green background and an image icon
          Container(
            color: Colors.green.shade100, // Light green background
            child: ListTile(
              leading: Image.asset(
                'assets/images/notesicon.png', // Replace with your image asset path for Notes
                width: 30.0,
                height: 30.0,
              ),
              title: const Text('Notes', style: TextStyle(fontFamily: 'Monserat'),),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const NoteScreen()), // Navigate to Notes Page
                );
              },
            ),
          ),
          // About ListTile with a red background and an image icon
          Container(
            color: Colors.purple.shade100, // Light red background
            child: ListTile(
              leading: Image.asset(
                'assets/images/usermanual.png', // Replace with your image asset path for About
                width: 30.0,
                height: 30.0,
              ),
              title: const Text('User Manual,', style: TextStyle(fontFamily: 'Monserat'),),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const UserManual()), // Navigate to AboutPage
                );
              },
            ),
          ),
          Container(
            color: Colors.red.shade100, // Light red background
            child: ListTile(
              leading: Image.asset(
                'assets/images/abouticon.png', // Replace with your image asset path for About
                width: 30.0,
                height: 30.0,
              ),
              title: const Text('About', style: TextStyle(fontFamily: 'Monserat'),),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const AboutPage()), // Navigate to AboutPage
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
