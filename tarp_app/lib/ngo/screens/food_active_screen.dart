import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tarp_app/ngo/widgets/food_post_card_mod.dart';

class NActiveFoodScreen extends StatefulWidget {
  final String status;
  final String what;
  final String who;
  const NActiveFoodScreen(
      {Key? key, required this.status, required this.what, required this.who})
      : super(key: key);

  @override
  State<NActiveFoodScreen> createState() => _NActiveFoodScreenState();
}

class _NActiveFoodScreenState extends State<NActiveFoodScreen> {
  late final String duid;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    duid = _auth.currentUser!.uid;
  }

  heading() {
    if (widget.status == 'active') {
      return Text(
        'Active Pickup',
        style: TextStyle(fontSize: 20, color: Colors.black54),
      );
    } else {
      return Text(
        'Completed Pickup',
        style: TextStyle(fontSize: 20, color: Colors.black54),
      );
    }
  }

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
            heading(),
            SizedBox(
              height: 10,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('foodposts')
                  .doc(duid)
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
