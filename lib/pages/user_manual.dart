import 'package:flutter/material.dart';
import 'package:todoapp/const/const.dart';
import 'package:todoapp/widgets/custom_drawer.dart';

class UserManual extends StatefulWidget {
  const UserManual({super.key});

  @override
  State<UserManual> createState() => _UserManualState();
}

class _UserManualState extends State<UserManual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Manual', style: TextStyle(fontFamily: 'Monserat'),),
        backgroundColor: headerColor,
      ),
      drawer: const CustomDrawer(), 
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 6, // Number of cards
          itemBuilder: (context, index) {
            // List of cards data
            final List<Map<String, String>> cardData = [
              {
                "image": "assets/images/usermanual/pic1.jpg",
                "title": "1. Open App",
                "description": "Open the app and you will be in the Homescreen."
              },
              {
                "image": "assets/images/usermanual/pic2.jpg",
                "title": "2. Side Navigation Bar",
                "description": "Pressed the navigation menu in the top left corner and navigate to the navigation bar."
              },
              {
                "image": "assets/images/usermanual/pic3.jpg",
                "title": "3. Add Task",
                "description": "Add task, task title and descriptions."
              },
              {
                "image": "assets/images/usermanual/pic4.jpg",
                "title": "4. Edit Task",
                "description": "You can edit tasks/notes."
              },
              {
                "image": "assets/images/usermanual/pic5.jpg",
                "title": "5. Add Notes.",
                "description": "You can add now notes."
              },
                            {
                "image": "assets/images/usermanual/pic6.jpg",
                "title": "6. Delete/Delete All.",
                "description": "You can delete tasks and notes either single deletion or delete all options."
              },
            ];

            // Retrieve card data for the current index
            final card = cardData[index];

            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.asset(
                      card["image"]!,
                      height: 200, // Adjust height to make the image more prominent
                      width: double.maxFinite,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      card["title"]!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Monserat',
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      card["description"]!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontFamily: 'Monserat',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
