// signup.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
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
                  ),
                ),
                SizedBox(height: 16.0),
                // Add your sign-up form or content here
                // For example, you can add text fields for email and password
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
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
                        // Handle sign-up logic here
                        // You can navigate to the home page or perform any other actions
                        // For simplicity, let's show a snackbar for now
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Sign Up Button Pressed'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // Keep the sign-up button color
                      ),
                      child: Text('Sign Up'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/login'); // Navigate to the login page
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // Change the login button color
                      ),
                      child: Text('Login'),
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
