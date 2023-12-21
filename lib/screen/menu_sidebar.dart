import 'package:flutter/material.dart';

import 'package:eco_enforce/screen/aboutUs.dart';
import 'check_complaint_status.dart';
import 'login.dart';

class MenuSideBar extends StatefulWidget {
  const MenuSideBar({super.key});

  @override
  State<MenuSideBar> createState() => _MenuSideBarState();
}

class _MenuSideBarState extends State<MenuSideBar> {
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
                  onTap: () {},
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
                    Icons.feed,
                    color: Color(0xFF016A70),
                  ),
                  title: const Text(
                    'Complaint Status',
                    style: TextStyle(
                        color: Color(0xFF2F8F0B),
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CheckComplaintStatus()),
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
