import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  final String title;
  final String description;
  final String timecooked;
  final String foodphotoUrl;
  final String address;
  final String lcity;
  final String pincode;
  final String status;
  final String donatoruid;
  final String datePublished = DateTime.now().toString();
  final String postId;
  final String ngoId;
  final String ngoname;
  final String volunteername;
  final String datepicked;

  Food({
    required this.title,
    required this.description,
    required this.timecooked,
    required this.foodphotoUrl,
    required this.address,
    required this.lcity,
    required this.pincode,
    required this.status,
    required this.donatoruid,
    datePublished,
    required this.postId,
    required this.ngoId,
    required this.ngoname,
    required this.volunteername,
    required this.datepicked,
  });

  static Food fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Food(
      title: snapshot['title'],
      description: snapshot['description'],
      timecooked: snapshot['timecooked'],
      foodphotoUrl: snapshot['foodphotoUrl'],
      address: snapshot['address'],
      lcity: snapshot['lcity'],
      pincode: snapshot['pincode'],
      status: snapshot['status'],
      donatoruid: snapshot['donatoruid'],
      datePublished: snapshot['datePublished'],
      postId: snapshot['postId'],
      ngoId: snapshot['ngoId'],
      ngoname: snapshot['ngoname'],
      volunteername: snapshot['voluntername'],
      datepicked: snapshot['datepicked'],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "timecooked": timecooked,
        "foodphotoUrl": foodphotoUrl,
        "address": address,
        "lcity": lcity,
        "pincode": pincode,
        "status": status,
        "donatoruid": donatoruid,
        "datePublished": datePublished,
        'postId': postId,
        "ngoId": ngoId,
        "ngoname": ngoname,
        "volunteername": volunteername,
        "datepicked": datepicked,
      };
}
