// // ignore_for_file: prefer_final_fields

// zimport 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:noteapp/models/note.dart';

// class AuthsController extends GetxController {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final _storage = GetStorage();
//   RxList<Note> notes = <Note>[].obs;

//   @override
//   void onInit() async {
//     super.onInit();
//     await refreshNotes();
//   }

//   Future<bool> signInWithCredentials(String email, String password) async {
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       if (userCredential.user != null) {
//         final uid = userCredential.user!.uid;
//         await fetchNotesForUser(uid);
//         _storage.write('auth_token_$uid', uid);
//         Get.offAllNamed('/home');
//         return true;
//       }
//     } on FirebaseAuthException catch (e) {
//       print("Error during sign-in: ${e.message}");
//     }
//     return false;
//   }

//   Future<List<Note>> fetchNotesForUser(String userId) async {
//     try {
//       final userNotesCollection = FirebaseFirestore.instance
//           .collection('users')
//           .doc(userId)
//           .collection('notes');
//       QuerySnapshot querySnapshot = await userNotesCollection.get();
//       List<Note> notes = querySnapshot.docs.map((doc) {
//         final data = doc.data() as Map<String, dynamic>;
//         return Note(
//           id: doc.id,
//           title: data['title'],
//           content: data['content'],
//           modifiedTime: data['modifiedTime'].toDate(),
//           doscId:data['docsId']
//         );
//       }).toList();
//       return notes;
//     } catch (e) {
//       print('Error fetching notes: $e');
//       throw e; // Optionally, you can re-throw the exception.
//     }
//   }

//   Future<bool> signUpWithEmailAndPassword(String email, String password) async {
//     try {
//       UserCredential userCredential =
//           await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       if (userCredential.user != null) {
//         final uid = userCredential.user!.uid;
//         await _firestore.collection('users').doc(uid).set({
//           'email': email,
//           'password': password,
//         });

//         return true;
//       } else {
//         return false;
//       }
//     } on FirebaseAuthException catch (e) {
//       print("Error during sign-up: ${e.message}");
//       return false;
//     }
//   }

//   Future<void> logOut() async {
//     try {
//       await _auth.signOut();
//       final user = _auth.currentUser;
//       if (user != null) {
//         final uid = user.uid;
//         _storage.remove('auth_token_$uid');
//       }

//       // Redirect to the login screen
//       Get.offAllNamed('/login');
//     } catch (e) {
//       print("Error during logout: $e");
//     }
//   }

//   Future<void> refreshNotes() async {
//     final user = _auth.currentUser;
//     try {
//       if (user != null) {
//         final uid = user.uid;
//         List<Note> newNotes = await fetchNotesForUser(uid);
//         notes.assignAll(newNotes); // Ensure userId is not null
//       }
//     } catch (error) {
//       // Tangani kesalahan jika diperlukan.
//       print("Error refreshing notes: $error");
//     }
//   }
// }

//   // Future<void> signOut() async {
//   //   await _auth.signOut();
//   //   await storage.remove('auth_token');
//   // }

//   // String? getToken() {
//   //   return storage.read('auth_token');
//   // }

