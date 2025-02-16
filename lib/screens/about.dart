import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // App Logo and Name
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFF2E6E6F), Colors.teal.shade300],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.contacts,
                    size: 80,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Contact Manager',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Developer Information
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                color: Colors.white.withOpacity(0.8),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.person, color: Color(0xFF2E6E6F)),
                        title: Text(
                          'Eddy Kubwimana',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 137, 119, 119),
                          ),
                        ),
                        subtitle: Text(
                          'Student ID: 83092025',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 137, 119, 119),
                          ),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.info, color: Color(0xFF2E6E6F)),
                        title: Text(
                          'About the App',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 137, 119, 119),
                          ),
                        ),
                        subtitle: Text(
                          'Contact Manager is a simple and intuitive app to manage your contacts. '
                          'You can add, edit, and delete contacts with ease. '
                          'Stay organized and keep your contacts in one place!',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 137, 119, 119),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const ListTile(
                        leading: Icon(Icons.star, color: Color(0xFF2E6E6F)),
                        title: Text(
                          'Fun Fact',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 137, 119, 119),
                          ),
                        ),
                        subtitle: Text(
                          'This app was built with ❤️ using Flutter!',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 137, 119, 119),
                          ),
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        leading:
                            const Icon(Icons.link, color: Color(0xFF2E6E6F)),
                        title: const Text(
                          'Follow Me',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 137, 119, 119),
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.facebook,
                                  color: Colors.blue),
                              onPressed: () {
                                // Add your Facebook link here
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.link, color: Colors.blue),
                              onPressed: () {
                                // Add your LinkedIn link here
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.code, color: Colors.blue),
                              onPressed: () {
                                // Add your GitHub link here
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
