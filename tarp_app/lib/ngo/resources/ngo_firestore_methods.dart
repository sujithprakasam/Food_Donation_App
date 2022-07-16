import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tarp_app/donator/models/food.dart' as model;

class NgoFireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> updateActive(String postId, String donatorId, String volname,
      String esttime, String ngoname) async {
    String res = "Some error Occurred";
    User currentUser = _auth.currentUser!;

    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('commonfoodposts')
          .doc(postId)
          .get();
      var foodData = userSnap.data();

      _firestore.collection('commonfoodposts').doc(postId).delete();

      _firestore
          .collection('foodposts')
          .doc(donatorId)
          .collection('post')
          .doc(postId)
          .delete();

      // ngo add
      _firestore
          .collection('foodposts')
          .doc(currentUser.uid)
          .collection('active')
          .doc(postId)
          .set(foodData!);

      // Donator add
      _firestore
          .collection('foodposts')
          .doc(donatorId)
          .collection('active')
          .doc(postId)
          .set(foodData);

      // ngo update
      await _firestore
          .collection('foodposts')
          .doc(currentUser.uid)
          .collection('active')
          .doc(postId)
          .update({
        'status': "active",
        'ngoId': currentUser.uid,
        'volunteername': volname,
        'datepicked': esttime,
        'ngoname': ngoname
      });

      // donator
      await _firestore
          .collection('foodposts')
          .doc(donatorId)
          .collection('active')
          .doc(postId)
          .update({
        'status': "active",
        'ngoId': currentUser.uid,
        'volunteername': volname,
        'datepicked': esttime,
        'ngoname': ngoname
      });

      await _firestore.collection('donators').doc(donatorId).update({
        'food_ongoing': FieldValue.arrayUnion([postId]),
        'food': FieldValue.arrayRemove([postId]),
      });

      await _firestore.collection('ngo').doc(currentUser.uid).update({
        'food_active': FieldValue.arrayUnion([postId]),
      });
      res = "success";
    } catch (err) {
      return err.toString();
    }

    return res;
  }

  Future<String> updateCompleted(String postId, String donatorId) async {
    String res = "Some error Occurred";
    User currentUser = _auth.currentUser!;

    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('foodposts')
          .doc(currentUser.uid)
          .collection('active')
          .doc(postId)
          .get();

      var foodData = userSnap.data();

      _firestore
          .collection('foodposts')
          .doc(currentUser.uid)
          .collection('active')
          .doc(postId)
          .delete();

      _firestore
          .collection('foodposts')
          .doc(donatorId)
          .collection('active')
          .doc(postId)
          .delete();

      // ngo add
      _firestore
          .collection('foodposts')
          .doc(currentUser.uid)
          .collection('completed')
          .doc(postId)
          .set(foodData!);

      // Donator add
      _firestore
          .collection('foodposts')
          .doc(donatorId)
          .collection('completed')
          .doc(postId)
          .set(foodData);

      // ngo update
      await _firestore
          .collection('foodposts')
          .doc(currentUser.uid)
          .collection('completed')
          .doc(postId)
          .update({
        'status': "completed",
        'datepicked': DateTime.now().toString(),
      });

      // donator
      await _firestore
          .collection('foodposts')
          .doc(donatorId)
          .collection('completed')
          .doc(postId)
          .update({
        'status': "completed",
        'datepicked': DateTime.now().toString(),
      });

      await _firestore.collection('donators').doc(donatorId).update({
        'food_completed': FieldValue.arrayUnion([postId]),
        'food_ongoing': FieldValue.arrayRemove([postId]),
        'fooddonations': FieldValue.increment(1),
      });

      await _firestore.collection('ngo').doc(currentUser.uid).update({
        'foodactive': FieldValue.arrayRemove([postId]),
        'foodcompleted': FieldValue.arrayUnion([postId]),
      });
      res = "success";
    } catch (err) {
      return err.toString();
    }

    return res;
  }
}
