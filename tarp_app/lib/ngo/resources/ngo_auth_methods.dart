import 'dart:typed_data';
import 'package:tarp_app/ngo/models/ngo.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tarp_app/donator/resources/donator_storage_methods.dart';

class NAuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // get ngo details

  Future<model.NGO> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.NGO.fromSnap(documentSnapshot);
  }

  // User Signup
  Future<String> NsignUpUser({
    required String ngoname,
    required String ngoregno,
    required String uniqueid,
    required String pannumber,
    required Uint8List file,
    required String city,
    required String state,
    required String nameofhead,
    required String address,
    required String location,
    required String pincode,
    required String email,
    required String mobilenumber,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (ngoname.isNotEmpty ||
          ngoregno.isEmpty ||
          uniqueid.isEmpty ||
          pannumber.isEmpty ||
          city.isEmpty ||
          state.isEmpty ||
          nameofhead.isEmpty ||
          address.isEmpty ||
          location.isEmpty ||
          pincode.isEmpty ||
          email.isEmpty ||
          mobilenumber.isEmpty ||
          password.isEmpty ||
          file != null) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('ngoProfilePics', file, false);
        model.NGO _user = model.NGO(
          ngoname: ngoname,
          ngoregno: ngoregno,
          uniqueid: uniqueid,
          pannumber: pannumber,
          city: city,
          state: state,
          nameofhead: nameofhead,
          address: address,
          location: location,
          pincode: pincode,
          email: email,
          mobilenumber: mobilenumber,
          password: password,
          ngoId: cred.user!.uid,
          foodactive: [],
          foodcompleted: [],
          otheritemsactive: [],
          otheritemscompleted: [],
          photoUrl: photoUrl,
        );

        // adding user in our database
        await _firestore
            .collection("ngo")
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

  // Login User
  Future<String> NloginUser({
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

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
