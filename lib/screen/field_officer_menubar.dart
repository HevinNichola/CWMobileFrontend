import 'package:flutter/material.dart';
import 'aboutUs.dart';
import 'field_officer_homepage.dart';
import 'login.dart';

class FieldOfficerMenuBar extends StatefulWidget {
  const FieldOfficerMenuBar({super.key});

  @override
  State<FieldOfficerMenuBar> createState() => _FieldOfficerMenuBarState();
}

class _FieldOfficerMenuBarState extends State<FieldOfficerMenuBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFFEBFAF3),
        child: ListView(
          children: [
            const SizedBox(height: 80),
            const Column(
              children: [
                Image(
                  image: AssetImage('assets/images/Logo without background.png'),
                  height: 200,
                  width: 200,
                )
              ],
            ),
            const Column(
              children: [
                Text('Menu',
                    style: TextStyle(
                        fontSize: 28,
                        color: Color(0xFF2F8F0B),
                        fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Color(0xFF016A70),
                  ),
                  title: const Text(
                    'Home',
                    style: TextStyle(
                        color: Color(0xFF2F8F0B), fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FieldOfficerHomePage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.info,
                    color: Color(0xFF016A70),
                  ),
                  title: const Text(
                    'About',
                    style: TextStyle(
                        color: Color(0xFF2F8F0B), fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutUs()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Color(0xFF016A70),
                  ),
                  title: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Color(0xFF2F8F0B),
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
