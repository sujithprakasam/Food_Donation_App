import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tarp_app/donator/utils.dart';
import 'package:tarp_app/donator/widgets/info_card.dart';
import 'package:tarp_app/donator/widgets/info_card_mod.dart';
import 'package:tarp_app/first_screen.dart';
import 'package:tarp_app/ngo/resources/ngo_auth_methods.dart';

class NGOProfileScreen extends StatefulWidget {
  final String uid;
  const NGOProfileScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<NGOProfileScreen> createState() => _NGOProfileScreenState();
}

class _NGOProfileScreenState extends State<NGOProfileScreen> {
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
          .collection('ngo')
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
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    // Flexible(
                    //   child: Container(),
                    //   flex: 1,
                    // ),
                    SizedBox(
                      height: 15,
                    ),
                    CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(userData['photoUrl']),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      userData['ngoname'],
                      style: TextStyle(
                        fontSize: 26.0,
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
                      text: userData['mobilenumber'],
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
                    InfoCard(
                      text: userData['uniqueid'],
                      icon: Icons.article_outlined,
                    ),
                    InfoCard(
                      text: userData['nameofhead'],
                      icon: Icons.person,
                    ),
                    InfoCard(
                      text: userData['pannumber'],
                      icon: Icons.credit_card,
                    ),
                    InfoCardMod(
                      text: 'Active Food Pickups',
                      status: 'active',
                      who: 'ngo',
                      what: 'food',
                    ),
                    InfoCardMod(
                      text: 'Completed Food Pickups',
                      status: 'completed',
                      who: 'ngo',
                      what: 'food',
                    ),
                    SizedBox(
                      height: 14,
                    ),

                    InkWell(
                      onTap: () async {
                        await NAuthMethods().signOut();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const FirstScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50.0,
                        width: 200,
                        color: Colors.transparent,
                        child: new Container(
                            decoration: new BoxDecoration(
                                color: Colors.red[300],
                                borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(10.0),
                                  topRight: const Radius.circular(10.0),
                                  bottomLeft: const Radius.circular(10.0),
                                  bottomRight: const Radius.circular(10.0),
                                )),
                            child: new Center(
                              child: new Text(
                                "Sign Out",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            )),
                      ),
                    ),

                    SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
