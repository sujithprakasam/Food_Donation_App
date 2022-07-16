import 'package:cloud_firestore/cloud_firestore.dart';

class Donator {
  final String email;
  final String uid;
  final String name;
  final String phoneNumber;
  final List food;
  final List food_ongiong;
  final List food_completed;
  final List others;
  final List others_ongoing;
  final List others_completed;
  final String location;
  final String photoUrl;
  final int fooddonations;
  final int othersdonations;

  const Donator({
    required this.name,
    required this.uid,
    required this.email,
    required this.phoneNumber,
    required this.food,
    required this.others,
    required this.location,
    required this.photoUrl,
    required this.food_ongiong,
    required this.food_completed,
    required this.others_ongoing,
    required this.others_completed,
    required this.fooddonations,
    required this.othersdonations,
  });

  static Donator fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Donator(
      name: snapshot["name"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      phoneNumber: snapshot["phoneNumber"],
      food: snapshot["food"],
      food_ongiong: snapshot["food_ongoing"],
      food_completed: snapshot["food_completed"],
      others: snapshot["others"],
      others_ongoing: snapshot["others_ongoing"],
      others_completed: snapshot["others_completed"],
      location: snapshot["location"],
      photoUrl: snapshot["photoUrl"],
      fooddonations: snapshot["fooddonations"],
      othersdonations: snapshot["otherdonations"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "email": email,
        "phoneNumber": phoneNumber,
        "food": food,
        "food_ongoing": food_ongiong,
        "food_completed": food_completed,
        "others": others,
        "others_ongoing": others_ongoing,
        "others_completed": others_completed,
        "location": location,
        "photoUrl": photoUrl,
        "fooddonations": fooddonations,
        "othersdonations": othersdonations,
      };
}
