import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tarp_app/donator/utils.dart';
import 'package:tarp_app/ngo/resources/ngo_firestore_methods.dart';
import 'package:tarp_app/ngo/screens/food_details_active_screen.dart';
import 'package:tarp_app/ngo/screens/ngo_screen_layout.dart';
import 'package:tarp_app/textinputfield.dart';

class FoodDetailConfirm extends StatefulWidget {
  final String postId;
  final String donatoruid;
  const FoodDetailConfirm({
    Key? key,
    required this.postId,
    required this.donatoruid,
  }) : super(key: key);

  @override
  _FoodDetailConfirmState createState() => _FoodDetailConfirmState();
}

class _FoodDetailConfirmState extends State<FoodDetailConfirm> {
  final TextEditingController _volnameController = TextEditingController();
  final TextEditingController _esttimeController = TextEditingController();
  var foodData = {};
  var ngoData = {};
  bool isLoading = false;
  bool isL = false;
  late final String uid;

  void confirmOrder() async {
    String res = 'Some Error Occurred';
    setState(() {
      isL = true;
    });
    try {
      uid = FirebaseAuth.instance.currentUser!.uid;

      var userSnap =
          await FirebaseFirestore.instance.collection('ngo').doc(uid).get();
      res = await NgoFireStoreMethods().updateActive(
          widget.postId,
          widget.donatoruid,
          _volnameController.text,
          _esttimeController.text,
          ngoData['ngoname']);
      if (res == "success") {
        setState(() {
          isL = false;
        });
        showSnackBar(
          context,
          'Posted!',
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => FoodDetailsActiveScreen(
              postId: widget.postId,
              donatorId: widget.donatoruid,
              ngoId: uid,
            ),
          ),
        );
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      setState(() {
        isL = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _volnameController.dispose();
    _esttimeController.dispose();
  }

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
          .collection('commonfoodposts')
          .doc(widget.postId)
          .get();

      foodData = userSnap.data()!;
      String uid = FirebaseAuth.instance.currentUser!.uid;
      var uSnap =
          await FirebaseFirestore.instance.collection('ngo').doc(uid).get();
      ngoData = uSnap.data()!;
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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.blue,
              size: 22.0,
            ),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const NgoScreenLayout(),
              ),
            ),
          ),
          title: Text(
            'Food Details',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                fontFamily: 'sans-serif-light',
                color: Colors.blue),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: EdgeInsets.only(top: 5),
                color: Colors.white,
                child: Scrollbar(
                  isAlwaysShown: true,
                  showTrackOnHover: true,
                  child: ListView(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.network(
                                        foodData['foodphotoUrl'],
                                        height: 200,
                                        width: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                            color: Color(0xffFFFFFF),
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 25.0, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'Food Information',
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            mainAxisSize: MainAxisSize.min,
                                          )
                                        ],
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'Title',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              foodData['title'],
                                            ),
                                          ),
                                        ],
                                      )),
                                  Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: Divider(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'Description',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              foodData['description'],
                                            ),
                                          ),
                                        ],
                                      )),
                                  Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: Divider(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'Time Cooked',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              foodData['timecooked'],
                                            ),
                                          ),
                                        ],
                                      )),
                                  Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: Divider(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'Address',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              foodData['address'],
                                            ),
                                          ),
                                        ],
                                      )),
                                  Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: Divider(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'Locality',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              foodData['lcity'],
                                            ),
                                          ),
                                        ],
                                      )),
                                  Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: Divider(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'Pincode',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              foodData['pincode'],
                                            ),
                                          ),
                                        ],
                                      )),
                                  Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: Divider(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                'Date posted',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 2.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              DateFormat.yMMMd().format(
                                                DateTime.parse(
                                                    foodData['datePublished']),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: Divider(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1000.0,
                                    height: 50.0,
                                  ),
                                  Center(
                                    child: Text(
                                      'Enter Details to Confirm Pickup',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 23,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 20),
                                      child: Column(
                                        children: [
                                          TextFieldInput(
                                            hintText:
                                                'Enter the Volunteer Name',
                                            textInputType: TextInputType.text,
                                            textEditingController:
                                                _volnameController,
                                          ),
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          TextFieldInput(
                                            hintText:
                                                'Enter the Estimated Time of Pickup',
                                            textInputType: TextInputType.text,
                                            textEditingController:
                                                _esttimeController,
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    width: 1000.0,
                                    height: 10.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(1),
                                        child: SizedBox(
                                          width: 200,
                                          height: 55,
                                          child: RaisedButton(
                                            child: isL
                                                ? CircularProgressIndicator(
                                                    color: Colors.white,
                                                  )
                                                : Text(
                                                    'Confirm Pick Up',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                            onPressed: () => confirmOrder(),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ));
  }
}
