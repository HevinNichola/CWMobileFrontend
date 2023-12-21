import 'package:eco_enforce/screen/field_officer_homepage.dart';
import 'package:eco_enforce/screen/update_progress.dart';
import 'package:eco_enforce/screen/view_complaint_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SelectComplaintPage extends StatefulWidget {
  const SelectComplaintPage({Key? key}) : super(key: key);

  @override
  State<SelectComplaintPage> createState() => _SelectComplaintPageState();
}

class _SelectComplaintPageState extends State<SelectComplaintPage> {
  late Future<Map<String, dynamic>> incident;

  @override
  void initState() {
    super.initState();
    incident = fetchIncident();
  }

  Future<Map<String, dynamic>> fetchIncident() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8444/api/incidents/1'),
      );
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to load complaint details');
      }
    } catch (e) {
      // Handle the exception here
      print('Error fetching incident: $e');
      return {}; // Return an empty map to avoid null errors
    }
  }

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
              MaterialPageRoute(builder: (context) => const FieldOfficerHomePage()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Map<String, dynamic>>(
          future: incident,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final incidentData = snapshot.data!;

              return Card(
                child: ListTile(
                  title: Text('Complaint ID: ${incidentData['incidentId'].toString()}'),
                  subtitle: Text('Name: ${incidentData['name']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewComplaint(incidentId: incidentData['incidentId'].toString()),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UpdateProgress(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF016A70),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          fixedSize: const Size(260, 58),
        ),
        child: const Text(
          'Update Complaint',
          style: TextStyle(
            fontSize: 18.5,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}