import 'dart:convert';
import 'package:eco_enforce/screen/make_complaint.dart';
import 'package:flutter/material.dart';
import 'package:eco_enforce/model/complaint_status_data.dart';
import 'package:http/http.dart' as http;


class ComplaintStatus extends StatefulWidget {
  final String incidentID;

  const ComplaintStatus({Key? key, required this.incidentID}) : super(key: key);

  @override
  State<ComplaintStatus> createState() => _ComplaintStatusState();
}

class _ComplaintStatusState extends State<ComplaintStatus> {
  late Future<ComplaintStatusData> futureComplaintStatusData;

  @override
  void initState() {
    super.initState();
    futureComplaintStatusData = fetchComplaintStatusData(widget.incidentID);
  }

  Future<ComplaintStatusData> fetchComplaintStatusData(String incidentID) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8444/api/incidents/$incidentID'), // Adjust the endpoint
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return ComplaintStatusData.fromJson(responseData);
      } else {
        throw Exception('Failed to load complaint status data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
       ('Error fetching complaint status data: $e');
      throw Exception('Error fetching complaint status data: $e');
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
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Complaint Status',
          style: TextStyle(color: Color(0xFF016A70), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<ComplaintStatusData>(
        future: futureComplaintStatusData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const Text('No data available');
          }

          final complaintStatusData = snapshot.data!;

          // Now you can use the complaintStatusData to display relevant information
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const SizedBox(
                 height: 40,
               ),

              buildInfoCard('Incident ID', complaintStatusData.incidentId.toString()),
              const SizedBox(
                height: 8,
              ),
              buildInfoCard('Status', complaintStatusData.status),
              const SizedBox(
                height: 8,
              ),
              buildInfoCard('Location', complaintStatusData.location),
              const SizedBox(
                height: 8,
              ),
              buildInfoCard('Timeframe', complaintStatusData.timeframe),
              const SizedBox(
                height: 8,
              ),
              buildInfoCard('Progress', complaintStatusData.progress),
              const SizedBox(
                height: 8,
              ),
              buildInfoCard('Comment', complaintStatusData.comment),
              // Add more fields as needed
              const SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MakeComplaint()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF016A70),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: const Size(285, 62),
                  ),
                  child: const Text(
                    "Make New Complaint",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  Widget buildInfoCard(String title, String value) {
    return Center(
      child: SizedBox(
      width: 400, // Set your desired width

      child: Card(
        color: const Color(0xFFF1F6F4),
        margin: const EdgeInsets.only(bottom: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '$title:  $value',
            style: const TextStyle(
              fontSize: 17,
            ),
          ),
        ),
      ),

      )
    );
  }
}