import 'package:cloud_firestore/cloud_firestore.dart';

class NGO {
  final String ngoname;
  final String ngoregno;
  final String uniqueid;
  final String pannumber;
  final String city;
  final String state;
  final String nameofhead;
  final String address;
  final String location;
  final String pincode;
  final String email;
  final String mobilenumber;
  final String password;
  final String ngoId;
  final List foodcompleted;
  final List foodactive;
  final List otheritemscompleted;
  final List otheritemsactive;
  final String photoUrl;
  NGO(
      {required this.ngoname,
      required this.ngoregno,
      required this.uniqueid,
      required this.pannumber,
      required this.city,
      required this.state,
      required this.nameofhead,
      required this.address,
      required this.location,
      required this.pincode,
      required this.email,
      required this.mobilenumber,
      required this.password,
      required this.ngoId,
      required this.foodcompleted,
      required this.foodactive,
      required this.otheritemscompleted,
      required this.otheritemsactive,
      required this.photoUrl});

  static NGO fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return NGO(
      ngoname: snapshot['ngoname'],
      ngoregno: snapshot['ngoregno'],
      uniqueid: snapshot['uinqueid'],
      pannumber: snapshot['pannumber'],
      city: snapshot['city'],
      state: snapshot['state'],
      nameofhead: snapshot['nameofhead'],
      address: snapshot['address'],
      location: snapshot['location'],
      pincode: snapshot['pincode'],
      email: snapshot['email'],
      mobilenumber: snapshot['mobilenumber'],
      password: snapshot['password'],
      ngoId: snapshot['ngoId'],
      foodactive: [],
      foodcompleted: [],
      otheritemsactive: [],
      otheritemscompleted: [],
      photoUrl: snapshot['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        "ngoname": ngoname,
        "ngoregno": ngoregno,
        "uniqueid": uniqueid,
        "pannumber": pannumber,
        "city": city,
        "state": state,
        "nameofhead": nameofhead,
        "address": address,
        "location": location,
        "pincode": pincode,
        "email": email,
        "mobilenumber": mobilenumber,
        "password": password,
        "ngoId": ngoId,
        "foodactive": foodactive,
        "foodcompleted": foodcompleted,
        "otheritemsactive": otheritemsactive,
        "otheritemscompleted": otheritemscompleted,
        "photoUrl": photoUrl
      };
}
// NGO NAME(as per NGO Darpan)
// NGO REG NO.(as per NGO Darpan)
// Unique Id of NGO
// PAN Card NUmber of NGO
// City of Registration
// State of Registration
// Name of Head of the NGO
// Address of the NGO
// Location of the NGO
// Pincode
// Email
// Mobile Number
// Password