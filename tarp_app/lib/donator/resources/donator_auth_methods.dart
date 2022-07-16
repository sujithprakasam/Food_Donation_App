import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tarp_app/donator/models/donator.dart' as model;
import 'package:flutter/material.dart';
import 'package:tarp_app/donator/resources/donator_storage_methods.dart';

class DAuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user details

  Future<model.Donator> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.Donator.fromSnap(documentSnapshot);
  }

  // Sign up User

  Future<String> DsignUpUser({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required Uint8List file,
    required String location,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          name.isNotEmpty ||
          phoneNumber.isNotEmpty ||
          location.isNotEmpty ||
          file != null) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('donatorProfilePics', file, false);
        model.Donator _user = model.Donator(
          name: name,
          uid: cred.user!.uid,
          email: email,
          phoneNumber: phoneNumber,
          food: [],
          food_ongiong: [],
          food_completed: [],
          others: [],
          others_ongoing: [],
          others_completed: [],
          location: location,
          photoUrl: photoUrl,
          fooddonations: 0,
          othersdonations: 0,
        );

        // adding user in our database
        await _firestore
            .collection("donators")
            .doc(cred.user!.uid)
            .set(_user.toJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // Log In User
  Future<String> DloginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }
}
