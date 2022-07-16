import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tarp_app/ngo/screens/food_screen.dart';
import 'package:tarp_app/ngo/screens/otheritems_screen.dart';
import 'package:tarp_app/ngo/screens/profile_screen.dart';

List<Widget> ngoScreenItems = [
  const NGOFoodScreen(),
  NGOProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
