import 'package:flutter/material.dart';
import 'package:todoapp/const/const.dart';
import 'package:todoapp/widgets/custom_drawer.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About',
          style: TextStyle(fontFamily: 'Monserat'),
        ),
        backgroundColor: headerColor,
      ),
      drawer: const CustomDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 242, 189, 255), // Start color
              Color.fromARGB(255, 251, 231, 163), // Start color
              Color.fromARGB(255, 160, 225, 240), // Start color
              Color.fromARGB(255, 194, 109, 237), // End color
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              // First Card
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                      child: Image.asset(
                        'assets/images/icon.png', // Ensure this path is correct
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'About Taskify',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Monserat',
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        'This app allows you to manage and organize your tasks efficiently. You can add, edit, and delete tasks as needed. The interface is simple and intuitive, designed to help you focus on what matters most.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: 'Monserat',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16), // Spacing between cards

              // Second Card
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                      child: Image.asset(
                        'assets/images/mision.png', // Ensure this path is correct
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'My Mission',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Monserat',
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Center(
                        child: Text(
                          'My mission is to help users achieve their goals by providing an efficient task management tool. I believe in simplicity and productivity, ensuring that our app serves as a reliable assistant for daily planning.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'Monserat',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                            Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                      child: Image.asset(
                        'assets/images/developer.png', // Ensure this path is correct
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Christian Barbosa',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Monserat',
                        ),
                      ),
                    ),
                  const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Developer',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Monserat',
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        'This app is developed by Christian Barbosa, A BSIT student from Leyte Normal University, with a mission to make an goal oriented and task management base application for the users. he came up with an idea of Taskify.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: 'Monserat',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
