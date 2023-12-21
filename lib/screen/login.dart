import 'dart:convert';
import 'package:eco_enforce/screen/register.dart';
import 'package:eco_enforce/screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eco_enforce/screen/homepage.dart';
import 'package:flutter/gestures.dart';
import 'field_officer_homepage.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String errorMessage = '';

  Future<void> login() async {
    if (formKey.currentState?.validate() ?? false) {
      final String username = usernameController.text.trim();
      final String password = passwordController.text.trim();

      try {
        final response = await http.post(
          Uri.parse('http://10.0.2.2:8444/api/users/login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'username': username,
            'password': password,
          }),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseBody = json.decode(response.body);
          String role = responseBody['role'];
          print('User role: $role');

          // Navigate to the appropriate page based on the role
          if (role == 'USER') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EcoEnforceHomepage()),
            );
          } else if (role == 'OFFICER') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FieldOfficerHomePage()),
            );
          }
        } else {
          setState(() {
            errorMessage = '*Invalid username or password';
          });
        }
      } catch (e) {
        print('Exception during login: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Login',
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
                    Image.asset('assets/images/Logo without background.png',
                        width: 350.0,
                        height: 350.0,
                        fit: BoxFit.cover
                    ),

                    Text(
                      errorMessage,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    TextFormField(
                      controller: usernameController,
                      style: const TextStyle(
                          color: Color(0xFF016A70), fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        labelText: ' Username',
                        labelStyle: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Color(0xFF44DC0C)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Color(0xFF016A70)),
                        ),
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Username is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: passwordController,
                        style: const TextStyle(
                            color: Color(0xFF016A70), fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                              color: Colors.black54, fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(color: Color(0xFF44DC0C)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            borderSide: BorderSide(color: Color(0xFF016A70)),
                          ),
                        ),
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return 'Password is required';
                          }
                          return null;
                        }
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    RichText(
                      text: TextSpan(
                          text: "Don't have an account?",
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: 'Register',
                              style: const TextStyle(
                                color: Color(0xFF2F8F0B),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = (){
                                  Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                                  );
                                },
                            )
                          ]
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF016A70),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        minimumSize: const Size(285, 62
                        ),
                      ),

                      child: const Text(
                        "Login",
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