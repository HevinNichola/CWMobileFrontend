import 'dart:convert';
import 'package:eco_enforce/screen/field_officer_homepage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eco_enforce/model/complaint_status_data.dart';

class ViewComplaint extends StatefulWidget {
  final String incidentId;

  const ViewComplaint({Key? key, required this.incidentId}) : super(key: key);

  @override
  State<ViewComplaint> createState() => _ViewComplaintState();
}

class _ViewComplaintState extends State<ViewComplaint> {
  late Future<List<ComplaintStatusData>> futureIncidents;

  @override
  void initState() {
    super.initState();
    futureIncidents = fetchData();
  }

  Future<List<ComplaintStatusData>> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8444/api/incidents/1'),
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        if (responseData is Map<String, dynamic> && responseData.containsKey('data')) {
          final dynamic jsonData = responseData['data'];

          if (jsonData is List<dynamic>) {
            List<ComplaintStatusData> complaintDataList = jsonData
                .map((json) => ComplaintStatusData.fromJson(json))
                .toList();
            return complaintDataList;
          } else if (jsonData is Map<String, dynamic>) {
            // If your data is a single object instead of a list, handle it accordingly
            return [ComplaintStatusData.fromJson(jsonData)];
          }
        }
      }

      // If the response doesn't meet the expected structure or there's an error
      return [];
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEBFAF3),
        leading: BackButton(
          color: const Color(0xFF016A70),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => const FieldOfficerHomePage(),
              ),
            );
          },
        ),
        title: const Text(
          'View Complaint',
          style: TextStyle(
            color: Color(0xFF016A70),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<ComplaintStatusData>>(
        future: futureIncidents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No complaints available.'));
          } else {
            List<ComplaintStatusData> incidents = snapshot.data!;

            return ListView.builder(
              itemCount: incidents.length,
              itemBuilder: (context, index) {
                ComplaintStatusData complaint = incidents[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text('Name: ${complaint.name}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Incident: ${complaint.incident}'),
                        Text('Status: ${complaint.status}'),
                        Text('Location: ${complaint.location}'),
                        Text('Timeframe: ${complaint.timeframe}'),
                        Text('Comment: ${complaint.comment}'),
                        Text('Progress: ${complaint.progress}'),
                        // Add other details as needed
                      ],
                    ),
                  ),
                );

              },
            );
          }
        },
      ),
    );
  }
}