// ignore_for_file: prefer_const_constructors, sort_child_properties_last, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:noteapp/controller/appwritecontroller.dart';
import 'package:get/get.dart';
import 'package:noteapp/controller/image.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});
  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  get pickImageFromGallery => null;
  final AppWriteAuthController appWriteAuthController = Get.find();

  void _handleSubmit() async {
    final success = await appWriteAuthController
        .addNote(appWriteAuthController.userIdToken.value);
    if (success) {
      // Show a success message, you can use SnackBar or any other UI feedback
      Get.snackbar(
        "Success",
        "Note added successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } else {
      // Show an error message if title or content is empty
      Get.snackbar(
        "Error",
        "Title and content cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 26, 26, 26),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  onPressed: () => Get.back(),
                  elevation: 8, // Add elevation here
                  backgroundColor: Colors.transparent,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.grey.shade800,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  )),
                ElevatedButton(
                  onPressed: () {
                    Get.find<ImagePickerController>().pickImageFromGallery();
                  },
                  child: Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.grey.shade800),
                    elevation: WidgetStateProperty.all<double>(8.0),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _handleSubmit();
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
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Column(children: <Widget>[
              TextField(
                controller: appWriteAuthController.titleController,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 30)),
              ),
              TextField(
                controller: appWriteAuthController.contentController,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type Something Here...',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16)),
              ),
              Obx(
                () {
                  final uploadedImages =
                      Get.find<ImagePickerController>().uploadedImages;
                  return Column(
                    children: uploadedImages.map((imagePath) {
                      return Stack(
                        children: [
                          Image.file(File(imagePath)),
                          Positioned(
                              top: 10,
                              right: 10,
                              child: ClipOval(
                                  child: SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Material(
                                        elevation: 0.0,
                                        color: Colors.grey.shade400
                                            .withOpacity(0.4),
                                        child: FloatingActionButton(
                                          onPressed: () {
                                            Get.find<ImagePickerController>()
                                                .removeImage(imagePath);
                                          },
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.black,
                                          ),
                                          elevation: 0.0,
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ))))
                        ],
                      );
                    }).toList(),
                  );
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
