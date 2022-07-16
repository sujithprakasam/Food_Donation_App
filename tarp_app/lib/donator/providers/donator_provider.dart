// import 'package:flutter/widgets.dart';
// import 'package:tarp_app/donator/models/donator.dart';
// import 'package:tarp_app/donator/resources/donator_auth_methods.dart';

// class DonatorProvider with ChangeNotifier {
//   Donator? _donator;
//   final DAuthMethods _authMethods = DAuthMethods();

//   Donator get getDonator => _donator!;

//   Future<void> refreshDonator() async {
//     Donator donator = await _authMethods.getUserDetails();
//     _donator = donator;
//     notifyListeners();
//   }
// }
