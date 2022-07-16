import 'dart:ffi';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarp_app/donator/models/food.dart';
import 'package:tarp_app/donator/resources/donator_storage_methods.dart';
import 'package:uuid/uuid.dart';

class DonatorFireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadFoodPost(
    String title,
    String description,
    String timecooked,
    String address,
    String lcity,
    String pincode,
    Uint8List file,
    String uid,
  ) async {
    String res = "Some error occurred";
    try {
      String foodphotoUrl =
          await StorageMethods().uploadImageToStorage('foodposts', file, true);
      String foodpostId = const Uuid().v1();
      Food food = Food(
        title: title,
        description: description,
        timecooked: timecooked,
        foodphotoUrl: foodphotoUrl,
        address: address,
        lcity: lcity,
        pincode: pincode,
        status: 'post',
        donatoruid: uid,
        datePublished: DateTime.now().toString(),
        postId: foodpostId,
        ngoId: '',
        ngoname: '',
        volunteername: '',
        datepicked: '',
      );
      _firestore
          .collection('foodposts')
          .doc(uid)
          .collection('post')
          .doc(foodpostId)
          .set(food.toJson());
      _firestore
          .collection('commonfoodposts')
          .doc(foodpostId)
          .set(food.toJson());

      _firestore.collection('donators').doc(uid).update({
        'food': FieldValue.arrayUnion([foodpostId]),
      });
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
