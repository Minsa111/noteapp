// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noteapp/models/note.dart';

class NoteController extends GetxController {
  final CollectionReference notesCollection =
      FirebaseFirestore.instance.collection('notes');
  var notes = <Note>[].obs;

  @override
  void onInit() {
    _fetchNotes();
    super.onInit();
  }

  void _fetchNotes() async {
    try {
      QuerySnapshot querySnapshot = await notesCollection.get();
      notes.assignAll(querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Note(
          id: doc.id,
          title: data['title'],
          content: data['content'],
          modifiedTime: data['modifiedTime'].toDate(),
        );
      }));
    } catch (e) {
      print('Error fetching notes: $e');
    }
  }
}
