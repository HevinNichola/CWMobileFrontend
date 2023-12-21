import 'package:flutter/material.dart';
import 'package:eco_enforce/screen/menu_sidebar.dart';
import 'package:eco_enforce/screen/check_complaint_status.dart';
import 'package:eco_enforce/screen/make_complaint.dart';

class EcoEnforceHomepage extends StatefulWidget {
  const EcoEnforceHomepage({super.key});

  @override
  State<EcoEnforceHomepage> createState() => _EcoEnforceHomepageState();
}

class _EcoEnforceHomepageState extends State<EcoEnforceHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuSideBar(),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEBFAF3),
        centerTitle: true,
        title: const Text(
          'Eco Enforce',
          style: TextStyle(color: Color(0xFF016A70)),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF016A70)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/images/pexels-satria-bagaskara-1642068.jpg'),
              const Text(
                'Environment Crime Complaint \n                     System',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              )
            ],
          ),
          Container(
              padding: const EdgeInsets.all(30),
              child: const Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                      style:
                      TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 20),
                      text: 'Making Online Complaints',
                      children: [
                        TextSpan(
                          text:
                          '\n\nComplaints submitted through this app undergo processing and will be '
                              'directed to the responsible wildlife and forest conservation institutions '
                              'for potential investigation. The initiation of any investigation based on '
                              'a filed complaint is at the discretion of the wildlife and forest conservation '
                              'institutions receiving the information',
                          style: TextStyle(
                              color: Color(0xFF2F8F0B),
                              height: 1.5,
                              fontSize: 14),
                        )
                      ]))),
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MakeComplaint()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF016A70),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22)),
                        fixedSize: const Size(285, 58)),
                child: const Text('Make a Complaint',
                  style: TextStyle(
                  fontSize: 18.5,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CheckComplaintStatus()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF016A70),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22)),
                      fixedSize: const Size(285, 58)),
                  child: const Text('Check Complaint Status',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
              ),
            ],
          )
        ],
      ),
    ),
    );
  }
}
