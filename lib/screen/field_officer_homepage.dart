import 'package:eco_enforce/screen/select_complaint_page.dart';

import 'package:flutter/material.dart';

import 'field_officer_menubar.dart';


class FieldOfficerHomePage extends StatefulWidget {
  const FieldOfficerHomePage({super.key});

  @override
  State<FieldOfficerHomePage> createState() => _FieldOfficerHomePageState();
}

class _FieldOfficerHomePageState extends State<FieldOfficerHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const FieldOfficerMenuBar(),
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
                Image.asset('assets/images/pexels-hendrik-cornelissen-2862070.jpg'),
                const Text(
                  'Environment Crime Complaint \n                     System',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 19),
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
                            fontSize: 21),
                        text: 'Investigate Incident',

                        children: [
                          TextSpan(
                            text:
                            '\n\nProvide a detailed status update for the '
                                 'environmental crime incident you are investigating.'
                                'Your input is crucial in ensuring effective resolution '
                                'and maintaining transparency. Please use the app to report your finding,actions taken and any '
                                'additional information relevant to the case. Your '
                                  'diligence contributes to the preservation of our '
                                 'environment and the enforcement of environmental regulations.',
                            style: TextStyle(
                                color: Color(0xFF2F8F0B),
                                height: 1.5,
                                fontSize: 14.5),
                          )
                        ]))),

            Column(
              children: [
                ElevatedButton(
                  onPressed: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SelectComplaintPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF016A70),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22)),
                      fixedSize: const Size(285, 58)),
                  child: const Text('View Complaint',
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
              ],
            )
          ],
        ),
      ),
    );
  }
}
