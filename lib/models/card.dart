// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors, avoid_print

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/models/note.dart';
import 'package:noteapp/constants/colors.dart';
import 'package:noteapp/controller/appwritecontroller.dart';
import 'package:noteapp/views/EditNote.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

getRandomColor() {
  Random random = Random();
  return backgroundColors[random.nextInt(backgroundColors.length)];
}

Card cardDesign(Note note) {
  final AppWriteAuthController appWriteAuthController = Get.find();
  final String noteId = note.id;
  final String docsId = note.docsId;

  print('noteId: ${note.id}');
  print('Title: ${note.title}');
  print('Content: ${note.content}');
  print('Modified Time: ${note.modifiedTime}');
  print('docsId: ${note.docsId}');

  void _handleDelete() async {
    final delete = await appWriteAuthController.deleteNote(docsId, noteId);
    if (delete) {
      Get.snackbar(
        "Success",
        "Note deleted successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } else {
      Get.snackbar(
        "Error",
        "Title and content cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

  return Card(
    margin: EdgeInsets.only(bottom: 20),
    color: getRandomColor(),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: RichText(
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: '${note.title} \n',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                height: 1.5),
            children: [
              TextSpan(
                  text: '${note.content}',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      height: 1.5))
            ],
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            '${DateFormat('EEE MMM d, yyyy h:mm a').format(note.modifiedTime)}',
            style: TextStyle(
                fontSize: 10,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade800),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () async {
                await Get.to(EditNoteScreen(), arguments: note);
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                _handleDelete();
              },
              icon: const Icon(Icons.delete_rounded),
            ),
          ],
        ),
      ),
    ),
  );
}
