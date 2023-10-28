// login.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'signup.dart'; // Import the SignUpScreen

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
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
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                // Add your login form or content here
                // For example, you can add text fields for username and password
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.offAndToNamed('/home');
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange, // Change the login button color
                      ),
                      child: Text('Login'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to the sign-up page when the button is pressed
                        Get.to(()=>SignUpScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // Change the sign-up button color
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
