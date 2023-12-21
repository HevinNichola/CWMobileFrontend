import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:eco_enforce/screen/homepage.dart';
import 'package:http/http.dart' as http;

const List<String> list = <String>['Wildlife Crime', 'Forestry Crime'];

class MakeComplaint extends StatefulWidget {
  const MakeComplaint({Key? key}) : super(key: key);

  @override
  State<MakeComplaint> createState() => _MakeComplaintState();
}

class _MakeComplaintState extends State<MakeComplaint> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  int dropdownValueIndex = 0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();


  Future<void> makeComplaint() async {
    // Validate the form
    if (formKey.currentState?.validate() ?? false) {
      try {
        final response = await http.post(
          Uri.parse('http://10.0.2.2:8444/api/incidents/save'),
          headers: {'Content-Type': 'application/json'}, // Add necessary headers
          body: jsonEncode({
            'name': nameController.text.trim(),
            'location': locationController.text.trim(),
            'incidentTypeId': dropdownValueIndex + 1,
            'incident': descriptionController.text.trim(),
          }),
        );

        if (response.statusCode == 200) {
          // Show a SnackBar with a success message
          scaffoldKey.currentState?.showSnackBar(
            const SnackBar(
              content: Text('Complaint submitted successfully!'),
              duration: Duration(seconds: 3),
              backgroundColor: Colors.green,
            ),
          );
          nameController.clear();
          locationController.clear();
          descriptionController.clear();


        } else {
          // Handle errors
          scaffoldKey.currentState?.showSnackBar(
            SnackBar(
              content: Text('Failed to submit complaint. Status code: ${response.statusCode}'),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      } catch (e) {
        // Handle exceptions
        scaffoldKey.currentState?.showSnackBar(
          SnackBar(
            content: Text('Exception during complaint submission: $e'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
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
          'Make a Complaint',
          style: TextStyle(color: Color(0xFF016A70), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
           child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 55,
              ),

              TextFormField(
                controller: nameController,
                style: const TextStyle(color: Color(0xFF016A70), fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  labelText: 'Full Name',
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
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter your name';
                  }
                  if(value.length < 3){
                    return 'Name must be at least 3 character long';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 40,
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
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter the location';
                  }
                  return null;
                },
              ),
              const SizedBox(
            height: 40,
            ),
              // Add the Complaint Type Dropdown
              DropdownButtonFormField<int>(
                value: dropdownValueIndex + 1,
                onChanged: (int? value) {
                  setState(() {
                    dropdownValueIndex = value! - 1;
                  });
                },
                items: const [
                  DropdownMenuItem<int>(
                    value: 1,
                    child: Text(
                      'Wildlife Crime',
                      style: TextStyle(color: Color(0xFF016A70), fontWeight: FontWeight.bold),
                    ),
                  ),
                  DropdownMenuItem<int>(
                    value: 2,
                    child: Text(
                      'Forestry Crime',
                      style: TextStyle(color: Color(0xFF016A70), fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                decoration: const InputDecoration(
                  labelText: 'Complaint Type',
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
                validator: (value){
                  if(value == null){
                    return 'Please select a complaint type';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 40,
              ),

              TextFormField(
                controller: descriptionController,
                minLines: 5,
                maxLines: 20,
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top,
                style: const TextStyle(
                    color: Color(0xFF016A70),
                    fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10, top: 10),
                    labelText: 'Complaint Description',
                    labelStyle: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(30)),
                        borderSide: BorderSide(color: Color(0xFF575F67))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(30)),
                        borderSide:
                        BorderSide(color: Color(0xFF016A70)
                        )
                    )
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter the complaint description';
                  }
                  if(value.length < 10){
                    return 'Description must be at least 10 character long';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 45,
              ),
              ElevatedButton(
                onPressed: makeComplaint,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF016A70),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  fixedSize: const Size(285, 60),
                ),
                child: const Text(
                  'Make Complaint',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
      ),
    ),
    );
  }
}


