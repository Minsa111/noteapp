// signup.dart
// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_element, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/controller/authcontroller.dart';
import 'package:noteapp/controller/notifcontroller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final AuthsController _auth = Get.find();

    void _handleSignUp() async {
      String email = emailController.text;
      String password = passwordController.text;

      if (email.isEmpty || password.isEmpty) {
        Get.snackbar("Error", "Email and password are required",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.1),
            colorText: Colors.red);
        return;
      }

      final signUpSuccessful =
          await _auth.signUpWithEmailAndPassword(email, password);

      if (signUpSuccessful) {
        Get.snackbar("Success", "Account has been created",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green);
            
      } else {
        Get.snackbar("Error", "Failed to create account. Try again",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.1),
            colorText: Colors.red);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: Colors.grey.shade800,
      ),
      backgroundColor: const Color.fromARGB(255, 23, 23, 23),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.green, // Change the background color
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sign Up Page',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
                SizedBox(height: 16.0),
                // Add your sign-up form or content here
                // For example, you can add text fields for email and password
                TextFormField(
                  controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText:'Insert Email',
                      filled: true,
                      fillColor: Colors.green.shade600,
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white54),
                   focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.black38),
                      
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent)
                    )
                  ),
                  style:TextStyle(color: Colors.white),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Insert Password',
                    filled: true,
                    fillColor: Colors.green.shade600,
                    hintStyle: TextStyle(color: Colors.white54),
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.black38),
                      
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.transparent)
                    )
                  ),
                  style:TextStyle(color: Colors.white),
                  obscureText: true,
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.back(); // Navigate to the login page
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // Change the login button color
                      ),
                      child: Text('Login'),
                    ),
                    ElevatedButton(
                      onPressed: _handleSignUp,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey.shade800,
                      ),
                      child: Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}