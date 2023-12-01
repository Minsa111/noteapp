// ignore_for_file: unused_field, avoid_print, unnecessary_null_comparison, unnecessary_cast

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/models/note.dart';

final client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('65631c1398656071fe82');

final account = Account(client);
final database = Databases(client);

class AppWriteAuthController extends GetxController {
  RxString userIdToken = ''.obs;
  RxList<Note> notes = <Note>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchNotes(userIdToken.value);
  }

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  void clearControllers() {
    titleController.clear();
    contentController.clear();
  }

  Future<bool> signUp(String email, String password) async {
    try {
      final uniqueUserId = ID.unique();
      final response = await account.create(
        userId: uniqueUserId,
        email: email,
        password: password,
      );
      final registrationSuccess = response != null;
      if (registrationSuccess) {
        userIdToken.value = response.$id;
        print('User registered successfully');
      }
      return registrationSuccess;
    } catch (e) {
      print('Error during registration: $e');
    }
    return false;
  }

  Future<bool> signIn(String email, String password) async {
    try {
      final response = await account.createEmailSession(
        email: email,
        password: password,
      );

      final userIdFromPreferences = response.userId != null;

      if (userIdFromPreferences) {
        account.get();
        userIdToken.value = response.userId;
        Get.offAllNamed('/home');
        print('User signed in successfully');
      }
      return userIdFromPreferences;
    } catch (e) {
      print('Error during sign in: $e');
    }
    return false;
  }

  Future<void> signOut() async {
    try {
      Future result = account.deleteSession(sessionId: 'current');
      result.then((responses) => {
            userIdToken.value = '',
            Get.offAllNamed('/login'),
            print('User signed out successfully')
          });
    } catch (e) {
      print('Error during sign out: $e');
    }
  }

  Future<bool> addNote(String documentIds) async {
    try {
      final title = titleController.text;
      final content = contentController.text;

      if (title.isNotEmpty && content.isNotEmpty) {
        await fetchNotes(documentIds);
        final uniqueUserId = ID.unique();
        final formatter = DateFormat('dd MMMM yyyy HH:mm:ss');
        final dateString = DateTime.now();
        final formattedTime = formatter.format(dateString);
        final parsedTime = formatter.parse(formattedTime);
        final newNote = Note(
          id: documentIds,
          title: title,
          content: content,
          modifiedTime: parsedTime,
        );
        notes.add(newNote);
        await database.createDocument(
          databaseId: '656887e4a140c5a4eb53',
          collectionId: '656887ea72cb5e633298',
          documentId: uniqueUserId,
          data: {
            'id': documentIds,
            'title': title,
            'content': content,
            'modifiedTime': formattedTime,
          },
        );
        await fetchNotesAfterAdd(documentIds);
        clearControllers();
        return true;
      } else {
        return false;
      }
    } on AppwriteException catch (e) {
      print('Error adding note: $e');
      return false;
    }
  }

  Future<void> fetchNotes(String userIdToken) async {
    try {
      final querys = Query.equal('id', userIdToken);

      final response = await database.listDocuments(
          databaseId: '656887e4a140c5a4eb53',
          collectionId: '656887ea72cb5e633298',
          queries: [querys]);

      final documentData = response.documents;
      if (documentData != null && documentData.isNotEmpty) {
        final note =
            documentData.map((doc) => Note.fromJson(doc.data)).toList();
        print('fetchNotes Successfully');
        print(userIdToken);
        notes.assignAll(note);
      } else {
        print('Data Null');
        notes.assignAll([]);
      }
    } on AppwriteException catch (e) {
      print('Error fetching notes: $e');
    }
  }

  Future<void> fetchNotesAfterAdd(String documentId) async {
    await fetchNotes(documentId);
  }
}
