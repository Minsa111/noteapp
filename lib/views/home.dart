// ignore_for_file: unnecessary_import, prefer_const_constructors, avoid_print, unused_element

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:noteapp/constants/colors.dart';
import 'package:noteapp/controller/appwritecontroller.dart';
import 'package:noteapp/models/navbar.dart';
import 'package:noteapp/controller/link.dart';
import 'package:noteapp/models/card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AppWriteAuthController _authControllers = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authControllers.fetchNotesAfterAdd(_authControllers.userIdToken.value);
    });
  }

  Widget buildNotesList() {
    return Obx(
      () => Expanded(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(
              const Duration(seconds: 2),
            );
            await _authControllers.fetchNotesAfterAdd(_authControllers
                .userIdToken
                .value); // Use await here to wait for the fetchNotes to complete
          },
          child: _authControllers.notes.isEmpty
              ? Center(
                  // child: CircularProgressIndicator(),
                  child: Text(
                    'Data Is Empty',
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.only(top: 15),
                  itemCount: _authControllers.notes.length,
                  itemBuilder: (context, index) {
                    return cardDesign(_authControllers.notes[index]);
                  },
                ),
        ),
      ),
    );
  }

  getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 26, 26, 26),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Notes',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            _authControllers.signOut();
                          },
                          padding: EdgeInsets.all(0),
                          icon: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Get.toNamed('/web'),
                          padding: EdgeInsets.all(0),
                          icon: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.smart_display_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            // TextField(
            //   style: TextStyle(fontSize: 16, color: Colors.white),
            //   decoration: InputDecoration(
            //     contentPadding: EdgeInsets.symmetric(vertical: 12),
            //     hintText: "Search Notes...",
            //     hintStyle: TextStyle(color: Colors.grey),
            //     prefixIcon: const Icon(
            //       Icons.search,
            //       color: Colors.grey
            //     ),
            //     fillColor: Colors.grey.shade800,
            //     filled: true,
            //     focusedBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(100),
            //       borderSide: const BorderSide(color: Colors.blue)
            //       ),
            //     enabledBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(100),
            //       borderSide: const BorderSide(color: Colors.red)
            //       )
            //   ),
            // ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: sampleNavbar.map((navbar) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(20), // Rounded corners
                      color:
                          Color.fromARGB(255, 69, 69, 69), // Background color
                    ),
                    height: 50, // Adjust the height as needed
                    width: 100, // Adjust the width as needed
                    margin: EdgeInsets.all(5),
                    child: Center(
                      child: Text(
                        navbar.content,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // ), Scrapped idea
            // RefreshIndicator(
            //     onRefresh: _refreshNotes,
            //     child: Obx(() {
            //       return ListView.builder(
            //           itemCount: _authController.notes.length,
            //           itemBuilder: (context, index) {
            //             return cardDesign(_authController.notes[index]);
            //           });
            //     }))
            buildNotesList()
            // RefreshIndicator(
            //   onRefresh: () async {
            //     await _refreshNotes();
            //   },
            //   child: ListView.builder(
            //     padding: EdgeInsets.only(top: 15),
            //     itemCount: _authController.notes.length,
            //     itemBuilder: (context, index) {
            //       return cardDesign(_authController.notes[index]);
            //     },
            //   ),
            // )
          ],
        ),
      ),
      floatingActionButton: editButton(context),
    );
  }
}
