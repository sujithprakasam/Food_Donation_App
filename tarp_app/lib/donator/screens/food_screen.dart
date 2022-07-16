import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tarp_app/donator/screens/food_post_screen.dart';
import 'package:tarp_app/donator/utils.dart';
import 'package:tarp_app/donator/widgets/food_post_card.dart';
import 'package:tarp_app/donator/widgets/info_card_mod.dart';

class DonatorFoodScreen extends StatefulWidget {
  const DonatorFoodScreen({Key? key}) : super(key: key);

  @override
  _DonatorFoodScreenState createState() => _DonatorFoodScreenState();
}

class _DonatorFoodScreenState extends State<DonatorFoodScreen> {
  var userData = {};
  late String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    super.initState();
    getFoodPosts();
  }

  void getFoodPosts() async {
    try {
      uid = FirebaseAuth.instance.currentUser!.uid;
      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddFoodPostScreen(),
              ),
            ),
            icon: const Icon(
              Icons.add,
              color: Colors.blue,
              size: 30,
            ),
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            InfoCardMod(
              text: 'Active Food Pickups',
              status: 'active',
              who: 'donators',
              what: 'food',
            ),
            InfoCardMod(
              text: 'Completed Food Pickups',
              status: 'completed',
              who: 'donators',
              what: 'food',
            ),
            Text(
              'Your Posts',
              style: TextStyle(fontSize: 20, color: Colors.black54),
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('foodposts')
                  .doc(uid)
                  .collection('post')
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
                    child: FoodPostCard(
                      snap: snapshot.data!.docs[index].data(),
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
