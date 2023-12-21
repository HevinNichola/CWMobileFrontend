import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'welcome_screen.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {


  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  Future<void> register() async {
    if (formKey.currentState?.validate() ?? false) {
      final String username = usernameController.text.trim();
      final String password = passwordController.text.trim();
      final String email = emailController.text.trim();

      try {
        final response = await http.post(
          Uri.parse('http://10.0.2.2:8444/api/users/register'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'username': username,
            'password': password,
            'email': email,
          }),
        );

        if (response.statusCode == 200) {

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          );
        } else {

          ('Registration failed. Status code: ${response.statusCode}');

        }
      } catch (e) {

        ('Exception during registration: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Register',
          style: TextStyle(
            color: Color(0xFF016A70),
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFEBFAF3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF016A70), size: 25,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Image.asset(
                'assets/images/Logo without background.png',
                width: 380.0,
                height: 380.0,
                fit: BoxFit.cover,
              ),

              TextFormField(
                controller: usernameController,
                style: const TextStyle(
                  color: Color(0xFF016A70),
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  labelText: ' Username',
                  labelStyle: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Color(0xFF44DC0C)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Color(0xFF016A70)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Username';
                  }
                  if (value.length < 3) {
                    return 'Username should contain than 3 characters';
                  }
                  if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                    return 'Username should only contain letters';
                  }
                  // Additional validation logic if needed
                  return null;
                },
              ),
              const SizedBox(
                height: 25,
              ),

              TextFormField(
                controller: passwordController,
                style: const TextStyle(
                  color: Color(0xFF016A70),
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Color(0xFF44DC0C)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Color(0xFF016A70)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (!RegExp(r'[A-Z]').hasMatch(value)) {
                    return 'Password must contain at least one uppercase and one lowercase letter';
                  }

                  // Additional validation logic if needed
                  return null;
                },

              ),
              const SizedBox(
                height: 25,
              ),

              TextFormField(
                controller: emailController,
                style: const TextStyle(
                  color: Color(0xFF016A70),
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  labelStyle: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Color(0xFF44DC0C)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Color(0xFF016A70)),
                  ),
                ),
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return 'Email is required';
                  }
                  RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                  if(!emailRegExp.hasMatch(email)){
                    return ' Invalid email format';
                  }
                  // Additional validation logic if needed
                  return null;
                },
              ),
                const SizedBox(
              height: 25,
              ),


              ElevatedButton(
                onPressed: register, // Call the register function
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF016A70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: const Size(280, 62),
                ),

                child: const Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
              ),
            ],
              ),
              ),
          ),
        ),
        );
  }
}
