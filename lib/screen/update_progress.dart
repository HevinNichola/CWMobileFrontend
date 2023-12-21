import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'homepage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class UpdateProgress extends StatefulWidget {
  const UpdateProgress({super.key});

  @override
  State<UpdateProgress> createState() => _UpdateProgressState();
}

class _UpdateProgressState extends State<UpdateProgress> {
  final TextEditingController complaintIdController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController progressStatusController = TextEditingController();
  final TextEditingController timeframeController = TextEditingController();
  final TextEditingController evidenceCommentController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  List<XFile> selectedImages = [];
  final GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();


  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (selectedImages.length < 3) {
          selectedImages.add(pickedFile);
        }
      });
    }
  }

  Future<void> updateProgress() async {
    try {
      final List<String> base64Images = await Future.wait(selectedImages.map((XFile file) async {
        List<int> imageBytes = await File(file.path).readAsBytes();
        return base64Encode(imageBytes);
      }));

      final response = await http.put(
        Uri.parse('http://10.0.2.2:8444/api/incidents/incidentcomment'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'incidentId': complaintIdController.text,
          'location': locationController.text,
          'status': progressStatusController.text,
          'image1': base64Images,
          'timeframe': timeframeController.text,
          'comment': evidenceCommentController.text,
          'startdate': startDateController.text,
          'progress': statusController.text,
        }),
      );

      if (response.statusCode == 200) {
        scaffoldKey.currentState?.showSnackBar(
            const SnackBar(
              content: Text('Progress Status Update successfully!'),
              duration: Duration(seconds: 3),
              backgroundColor: Colors.green,
            ),
        );
      } else {
        // Handle error response
        ('Failed to update progress. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      ('Error updating progress: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        startDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFFEBFAF3),
        leading: BackButton(
          color: const Color(0xFF016A70),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => const EcoEnforceHomepage()),
            );
          },
        ),
        title: const Text(
          'Update Progress',
          style: TextStyle(color: Color(0xFF016A70), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: complaintIdController,
                style: const TextStyle(color: Color(0xFF016A70), fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  labelText: 'Complaint ID',
                  labelStyle: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Color(0xFF575F67)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Color(0xFF016A70)),
                  ),
                ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Complaint ID is required';
                    }
                    return null;
                  }
              ),
              const SizedBox(
                height: 20,
              ),

              TextFormField(
                controller: locationController,
                style: const TextStyle(color: Color(0xFF016A70), fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  labelText: 'Location',
                  labelStyle: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Color(0xFF575F67)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Color(0xFF016A70)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: progressStatusController,
                style: const TextStyle(color: Color(0xFF016A70), fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  labelText: 'Progress Status',
                  labelStyle: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Color(0xFF575F67)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Color(0xFF016A70)),
                  ),
                ),
                   validator: (value) {
                     if (value == null || value.isEmpty) {
                       return 'Progress Status is required';
                     }
                     return null;
                   }
              ),
              const SizedBox(
                height: 20,
              ),

              TextFormField(
                controller: statusController,
                style: const TextStyle(color: Color(0xFF016A70), fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  labelText: 'Status',
                  labelStyle: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Color(0xFF575F67)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Color(0xFF016A70)),
                  ),
                ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Progress Status is required';
                    }
                    return null;
                  }
              ),
              const SizedBox(
                height: 20,
              ),

              TextFormField(
                controller: startDateController,
                style: const TextStyle(color: Color(0xFF016A70), fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: 'Start Date',
                  labelStyle: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Color(0xFF575F67)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Color(0xFF016A70)),
                  ),
                  suffixIcon: InkWell(
                    onTap: () async {
                      await _selectDate(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Icon(
                        Icons.calendar_today,
                        color: Color(0xFF575F67), // Choose your desired color
                      ),
                    ),
                  ),
                ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Start Date is required';
                    }
                    return null;
                  }
              ),
              const SizedBox(
                height: 20,
              ),

              TextFormField(
                controller: timeframeController,
                style: const TextStyle(color: Color(0xFF016A70), fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  labelText: 'Timeframe',
                  labelStyle: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Color(0xFF575F67)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Color(0xFF016A70)),
                  ),
                ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'TimeFramed is required';
                    }
                    return null;
                  }

              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: evidenceCommentController,
                style: const TextStyle(color: Color(0xFF016A70), fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  labelText: 'Evidence Comment',
                  labelStyle: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Color(0xFF575F67)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Color(0xFF016A70)),
                  ),
                ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'TimeFramed is required';
                    }
                    return null;
                  }
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _getImage,
                child: const Text('Add Image'),
              ),
              if (selectedImages.isNotEmpty)
                Row(
                  children: [
                    for (var image in selectedImages)
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Image.file(
                          File(image.path),
                          height: 100,
                          width: 100,
                        ),
                      ),
                  ],
                ),
              const SizedBox(
                height: 20,
              ),

              ElevatedButton(
                  onPressed: updateProgress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF016A70),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    fixedSize: const Size(285, 60),
                  ),
                  child: const Text(
                    'Update Investigation Process',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}