import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tarp_app/donator/screens/food_screen.dart';
import 'package:tarp_app/donator/screens/otheritems_screen.dart';
import 'package:tarp_app/donator/screens/profile_screen.dart';

List<Widget> donatorScreenItems = [
  const DonatorFoodScreen(),
  DonatorProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
