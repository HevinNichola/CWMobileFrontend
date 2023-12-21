import 'package:flutter/material.dart';
import 'package:eco_enforce/screen/homepage.dart';
import 'complaint_status.dart'; //

class CheckComplaintStatus extends StatefulWidget {
  const CheckComplaintStatus({Key? key}) : super(key: key);

  @override
  State<CheckComplaintStatus> createState() => _CheckComplaintStatusState();
}

class _CheckComplaintStatusState extends State<CheckComplaintStatus> {
  TextEditingController complaintIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4FAF6),
        title: const Text(
          'Check Complaint Status',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF016A70)),
        ),
        centerTitle: true,
        leading: BackButton(
          color: const Color(0xFF016A70),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => const EcoEnforceHomepage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: complaintIdController,
              style: const TextStyle(color: Color(0xFF016A70), fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                labelText: 'Complaint ID',
                labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF575F67)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(23)),
                  borderSide: BorderSide(color: Color(0xFF5EB23F)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Color(0xFF5EB23F)),
                ),
              ),

            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                String incidentID = complaintIdController.text.trim();

                // Navigate to ComplaintStatus page and pass the complaint ID
                if (incidentID.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please enter a valid Complaint ID.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Navigate to ComplaintStatus page and pass the complaint ID
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ComplaintStatus(incidentID: incidentID),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF016A70),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                fixedSize: const Size(285, 58),
              ),
              child: const Text(
                'Check Complaint Status',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}