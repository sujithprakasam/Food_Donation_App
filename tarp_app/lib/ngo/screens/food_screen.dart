import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tarp_app/donator/widgets/food_post_card.dart';
import 'package:tarp_app/donator/widgets/info_card_mod.dart';
import 'package:tarp_app/ngo/widgets/food_post_card_inactive.dart';

class NGOFoodScreen extends StatefulWidget {
  const NGOFoodScreen({Key? key}) : super(key: key);

  @override
  _NGOFoodScreenState createState() => _NGOFoodScreenState();
}

class _NGOFoodScreenState extends State<NGOFoodScreen> {
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
            Text(
              'Available Pickup',
              style: TextStyle(fontSize: 20, color: Colors.black54),
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('commonfoodposts')
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
                    child: FoodPostCardInactive(
                      snap: snapshot.data!.docs[index].data(),
                      sc: 0,
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
