import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tarp_app/donator/utils.dart';
import 'package:tarp_app/donator/widgets/info_card.dart';

class DonatorProfileScreen extends StatefulWidget {
  final String uid;

  const DonatorProfileScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  _DonatorProfileScreenState createState() => _DonatorProfileScreenState();
}

class _DonatorProfileScreenState extends State<DonatorProfileScreen> {
  var userData = {};
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('donators')
          .doc(widget.uid)
          .get();

      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              minimum: const EdgeInsets.only(top: 90),
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: Container(),
                    flex: 1,
                  ),
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(userData['photoUrl']),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    userData['name'],
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Pacifico",
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    width: 200,
                    child: Divider(
                      color: Colors.white,
                    ),
                  ),
                  InfoCard(
                    text: userData['phoneNumber'],
                    icon: Icons.phone,
                  ),
                  InfoCard(
                    text: userData['location'],
                    icon: Icons.location_city,
                  ),
                  InfoCard(
                    text: userData['email'],
                    icon: Icons.email,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            child: Text(
                              userData['fooddonations'].toString(),
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                            radius: 44,
                            backgroundColor: Colors.blue,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              'Food Donations',
                              style: TextStyle(
                                fontFamily: "Source Sans Pro",
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Flexible(
                    child: Container(),
                    flex: 20,
                  ),
                ],
              ),
            ),
          );
  }
}
