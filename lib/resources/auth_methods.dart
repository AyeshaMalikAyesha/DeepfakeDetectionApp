import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_vision/models/user.dart' as model;
import 'package:fake_vision/resources/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    //this user is provided by firebase auth
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  //signup the user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String result = "Some error occurred";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          bio.isNotEmpty &&
          username.isNotEmpty &&
          file != null) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePic', file, false);

        model.User user = model.User(
            username: username,
            uid: cred.user!.uid,
            email: email,
            bio: bio,
            photoUrl: photoUrl);

        //add user to our database
        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        result = "success";
      } else {
        result = "Please fill all the fields!!";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        result = 'The email is badly formatted';
      } else if (err.code == 'weak-password') {
        result = 'Password should be at least 6 characters';
      }
    } catch (err) {
      result = err.toString();
    }

    return result;
  }

//logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String result = "Some errror occured";

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        result = "success";
      } else {
        result = "Please fill all the fields!!";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        result = "user not found";
      } else if (e.code == 'wrong-password') {
        result = "Wrong password";
      } else if (e.code == 'invalid-email') {
        result = 'The email is badly formatted';
      } else if (e.code == "INVALID_LOGIN_CREDENTIALS") {
        result = "Invalid Login Credentials";
      }
      print(e.message);
    } catch (err) {
      result = err.toString();
    }

    return result;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
