// splash.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login.dart'; // Import the LoginScreen

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Tambahkan efek fade-in menggunakan AnimatedOpacity
    _fadeIn();
  }

  _fadeIn() async {
    await Future.delayed(Duration(milliseconds: 500)); // Delay sebentar sebelum fade-in
    setState(() {
      _opacity = 1.0;
    });

    // Tambahkan delay sebelum fade-out
    await Future.delayed(Duration(seconds: 2));

    // Tambahkan efek fade-out
    _fadeOut();
  }

  _fadeOut() {
    setState(() {
      _opacity = 0.0;
    });

    // Tambahkan delay sebelum pindah ke layar login setelah fade-out
    Future.delayed(Duration(milliseconds: 500), () {
      Get.offAndToNamed('/login');
    });
  }

  double _opacity = 0.0; // Nilai awal opacity

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 69, 71, 75),
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: Duration(seconds: 1), // Durasi animasi fade-in dan fade-out
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ganti dengan widget Image untuk menampilkan gambar
              Image.asset(
                'assets/Logo.png', // Ganti dengan path gambar Anda
                width: 120.0, // Sesuaikan ukuran gambar sesuai kebutuhan
                height: 120.0,
              ),
              SizedBox(height: 16.0), // Berikan sedikit ruang antara gambar dan teks
              Text(
                'NoteApps',
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
