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
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 169, 255, 159),
                    Color.fromARGB(255, 229, 159, 255),
                    Color.fromARGB(255, 159, 255, 223),
                    Color.fromARGB(255, 184, 250, 255),
                    Color.fromARGB(255, 255, 234, 169),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  // Drawer Header with adjustable height, image, text, and small text
                  Stack(
                    children: [
                      Container(
                        height: 140.0, // Adjust the height as needed
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/header.gif'), // Replace with your image asset path
                            fit: BoxFit.cover, // Ensures the image covers the entire area
                          ),
                        ),
                      ),
                      Container(
                        height: 140.0,
                        alignment: Alignment.center,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Taskify',
                              style: TextStyle(
                                fontFamily: 'Monserat',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    offset: Offset(2, 2),
                                    blurRadius: 4,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'Stay organized and productive!',
                              style: TextStyle(
                                fontFamily: 'Monserat',
                                fontSize: 13,
                                color: Colors.black54,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 1,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 2.0),
                            Text(
                              'Developed by: Christian Barbosa',
                              style: TextStyle(
                                fontFamily: 'Monserat',
                                fontSize: 10,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Task ListTile
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      border: Border.all(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/taskicon.png',
                        width: 30.0,
                        height: 30.0,
                      ),
                      title: const Text(
                        'Task',
                        style: TextStyle(fontFamily: 'Monserat'),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Homescreen()),
                        );
                      },
                    ),
                  ),
                  // Notes ListTile
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      border: Border.all(color: Colors.green, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/notesicon.png',
                        width: 30.0,
                        height: 30.0,
                      ),
                      title: const Text(
                        'Notes',
                        style: TextStyle(fontFamily: 'Monserat'),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NoteScreen()),
                        );
                      },
                    ),
                  ),
                  // User Manual ListTile
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.purple.shade100,
                      border: Border.all(color: Colors.purple, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/usermanual.png',
                        width: 30.0,
                        height: 30.0,
                      ),
                      title: const Text(
                        'User Manual',
                        style: TextStyle(fontFamily: 'Monserat'),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserManual()),
                        );
                      },
                    ),
                  ),
                  // About ListTile
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      border: Border.all(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/abouticon.png',
                        width: 30.0,
                        height: 30.0,
                      ),
                      title: const Text(
                        'About',
                        style: TextStyle(fontFamily: 'Monserat'),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutPage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Footer Text
          Container(
            color: Colors.grey.shade200,
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              '    © 2024 Taskify. All   Rights   Reserved.  ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
