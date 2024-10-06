// login.dart
// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_element, avoid_print
//test
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/controller/appwritecontroller.dart';
import 'signup.dart'; // Import the SignUpScreen

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final AppWriteAuthController _authController = Get.find();
    Future<void> _subscribeToTopic(String topic) async {
      await FirebaseMessaging.instance.subscribeToTopic(topic);
    }

    void _handleSignIn() async {
      final email = emailController.text;
      final password = passwordController.text;

      if (email.isEmpty || password.isEmpty) {
        Get.snackbar("Error", "Email and password are required",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.1),
            colorText: Colors.red);
        return;
      }

      final loginSuccessful = await _authController.signIn(email, password);

      if (loginSuccessful) {
        Get.offAndToNamed('/home');

        Get.snackbar("Success", "Logged in successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green);
      } else {
        Get.snackbar("Error", "Failed to log in. Check your email and password",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.1),
            colorText: Colors.red);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        backgroundColor: Colors.grey.shade800,
      ),
      backgroundColor: const Color.fromARGB(255, 23, 23, 23),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.blue,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Login Page',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Insert Email',
                      filled: true,
                      fillColor: Colors.blue.shade600,
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white54),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black38),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(color: Colors.transparent))),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Insert Password',
                      filled: true,
                      hintStyle: TextStyle(color: Colors.white54),
                      labelStyle: TextStyle(color: Colors.white),
                      fillColor: Colors.blue.shade600,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.black38),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(color: Colors.transparent))),
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _handleSignIn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade800,
                      ),
                      child: Text('Login'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to the sign-up page when the button is pressed
                        Get.to(() => SignUpScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.green, // Change the sign-up button color
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
