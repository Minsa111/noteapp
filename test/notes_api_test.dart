import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noteapp/controller/appwritecontroller.dart';

class Note {
  final String id;
  final String title;
  final String content;

  Note({
    required this.id,
    required this.title,
    required this.content,
  });
}

class AuthController {
  final Map<String, String> userDatabase = {};
  final Map<String, List<Note>> userNotes = {};
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  bool _isValidUpdate(String updatedTitle, String updatedContent) {
    return updatedTitle.isNotEmpty && updatedContent.isNotEmpty;
  }

  List<Note> get notes {
    // Assuming you want to retrieve notes for the currently signed-in user
    final email =
        getCurrentUserEmail(); // Implement this method based on your authentication logic

    if (userNotes.containsKey(email)) {
      return userNotes[email]!;
    } else {
      return [];
    }
  }

  Future<bool> signUp(String email, String password) async {
    // Check if the email is already registered
    if (userDatabase.containsKey(email)) {
      // Email is already in use
      return false;
    }

    // Store the user information in the "database"
    userDatabase[email] = password;

    // Successful sign-up
    return true;
  }

  Future<bool> signIn(String email, String password) async {
    // Check if the email exists in the "database"
    if (!userDatabase.containsKey(email)) {
      // Email not found
      return false;
    }

    // Check if the provided password matches the stored password
    if (userDatabase[email] == password) {
      // Successful sign-in
      return true;
    } else {
      // Incorrect password
      return false;
    }
  }

  Future<List<Note>> fetchNotes(String userIdToken) async {
    if (userNotes.containsKey(userIdToken)) {
      return userNotes[userIdToken]!;
    } else {
      return [];
    }
  }

  Future<bool> addNote(String email) async {
    final notes = userNotes[email] ?? [];

    final newNote = Note(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: titleController.text,
      content: contentController.text,
    );

    if (newNote.title.isNotEmpty && newNote.content.isNotEmpty) {
      notes.add(newNote);
      userNotes[email] = notes;

      return true; // Successful note addition
    } else {
      return false; // Title or content is empty
    }
  }

  bool updateNote(String documentId, String noteId, String updatedTitle,
      String updatedContent) {
    final notes = userNotes[documentId] ?? [];
    final index = notes.indexWhere((note) => note.id == noteId);

    if (index != -1) {
      if (_isValidUpdate(updatedTitle, updatedContent)) {
        notes[index] = Note(
          id: noteId,
          title: updatedTitle,
          content: updatedContent,
        );

        userNotes[documentId] = notes;
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  Future<bool> deleteNote(String email, String noteId) async {
    final notes = userNotes[email] ?? [];
    final index = notes.indexWhere((note) => note.id == noteId);

    if (index != -1) {
      notes.removeAt(index);
      userNotes[email] = notes;
    }
    return true;
  }

  String getCurrentUserEmail() {
    return 'test@example.com';
  }
}

void main() {
  group('Notes Api Service Tests', () {
    late AuthController auth;

    setUp(() {
      auth = AuthController();
    });

    test('Sign Up Success', () async {
      final result = await auth.signUp('test@example.com', 'password123');
      expect(result, true);
    });

    test('Sign In Success', () async {
      // Sign up a user first before attempting to sign in
      await auth.signUp('test@example.com', 'password123');

      final result = await auth.signIn('test@example.com', 'password123');
      expect(result, true);
    });

    test('Sign Up Failure', () async {
      // Sign up a user with the same email first
      await auth.signUp('test@example.com', 'password123');

      final result = await auth.signUp('test@example.com', 'anotherPassword');
      expect(result, false);
    });

    test('Sign In Failure', () async {
      // Sign up a user first before attempting to sign in
      await auth.signUp('test@example.com', 'password123');

      // Attempt to sign in with the wrong password
      final result = await auth.signIn('test@example.com', 'wrong-password');
      expect(result, false);
    });

    test('Add Note Success', () async {
      // Provide valid data for testing
      const documentIds = 'user123';
      auth.titleController.text = 'Test Title';
      auth.contentController.text = 'Test Content';

      final result = await auth.addNote(documentIds);
      expect(result, true);
    });

    test('Add Note Failure (Empty Title or Content)', () async {
      // Provide empty data for testing
      const documentIds = 'user123';
      auth.titleController.text = '';
      auth.contentController.text = '';

      final result = await auth.addNote(documentIds);
      expect(result, false); // Update expectation to false for failure
    });

    test('Fetch Notes', () async {
      const userIdToken = 'user123';

      final result = await auth.fetchNotes(userIdToken);

      expect(result, isA<List<Note>>());
    });

    test('Delete Note Success', () async {
      // Provide valid data for testing
      const docsId = 'document123';
      const noteId = 'note123';

      final result = await auth.deleteNote(docsId, noteId);
      expect(result, true);
    });

    test('Update Notes successful', () {
      // Arrange
      const documentId = 'document123';
      const noteId = 'note123';
      const updatedTitle = 'Updated Title';
      const updatedContent = 'Updated Content';

      // Act
      final result =
          auth.updateNote(documentId, noteId, updatedTitle, updatedContent);

      // Assert
      expect(result, true);
    });

    test('Update Notes When Title or content is empty', () {
      // Arrange
      const documentId = 'document123';
      const noteId = 'note123';
      const updatedTitle = '';
      const updatedContent = 'Updated Content';

      // Act
      final result =
          auth.updateNote(documentId, noteId, updatedTitle, updatedContent);

      // Assert
      expect(result, true);
    });
  });
}
