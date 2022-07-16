import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tarp_app/ngo/widgets/food_post_card_inactive.dart';
import 'package:tarp_app/ngo/widgets/food_post_card_mod.dart';

class DFoodAcScreen extends StatefulWidget {
  final String status;
  final String what;
  final String who;
  const DFoodAcScreen({
    Key? key,
    required this.status,
    required this.what,
    required this.who,
  }) : super(key: key);

  @override
  State<DFoodAcScreen> createState() => _DFoodAcScreenState();
}

class _DFoodAcScreenState extends State<DFoodAcScreen> {
  late String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Text(
              'Active Pickup',
              style: TextStyle(fontSize: 20, color: Colors.black54),
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('foodposts')
                  .doc(uid)
                  .collection(widget.status)
                  .orderBy('datePublished', descending: true)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (ctx, index) => Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    child: NFoodPostCardMod(
                      snap: snapshot.data!.docs[index].data(),
                      status: widget.status,
                      what: widget.what,
                      who: widget.who,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
