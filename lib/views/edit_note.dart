// edit_note_screen.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:noteapp/controller/appwritecontroller.dart';
import 'package:get/get.dart';
import 'package:noteapp/controller/image.dart';
import 'package:noteapp/models/note.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});
  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final AppWriteAuthController appWriteAuthController = Get.find();

  @override
  void initState() {
    super.initState();

    // Retrieve the note data passed from the previous screen
    final Note note = Get.arguments as Note;

    // Set the title and content in the controllers for editing
    appWriteAuthController.titleController.text = note.title;
    appWriteAuthController.contentController.text = note.content;
  }

  void _handleUpdate() async {
    // Get the note ID and document ID from the selected note
    final Note note = Get.arguments as Note;
    final String docsId = note.docsId;
    final String noteId = note.id;

    // Call the updateNote method from the controller
    final success = await appWriteAuthController.updateNote(docsId, noteId);

    if (success) {
      // Show a success message
      Get.snackbar(
        "Success",
        "Note updated successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } else {
      // Show an error message
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
      backgroundColor: const Color.fromARGB(255, 26, 26, 26),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                    onPressed: () {
                      Get.back();
                      appWriteAuthController.clearControllers();
                    },
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
                    // Add logic to handle image picking if needed
                    // Get.find<ImagePickerController>().pickImageFromGallery();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey.shade800),
                    elevation: MaterialStateProperty.all<double>(8.0),
                  ),
                  child: const Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Call the update method when check icon is pressed
                    _handleUpdate();
                  },
                  padding: const EdgeInsets.all(0),
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
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
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 30)),
              ),
              TextField(
                controller: appWriteAuthController.contentController,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white),
                decoration: const InputDecoration(
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
                                          elevation: 0.0,
                                          backgroundColor: Colors.transparent,
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.black,
                                          ),
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
