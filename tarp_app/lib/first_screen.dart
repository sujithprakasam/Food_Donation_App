import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tarp_app/donator/screens/login_screen.dart';
import 'package:tarp_app/ngo/screens/login_screen.dart';
import 'package:tarp_app/ngo/screens/signup_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: Container(
                  width: double.infinity,
                  decoration: new BoxDecoration(
                      color: Color.fromARGB(255, 19, 102, 209),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  padding: EdgeInsets.all(30),
                  child: Center(
                      child: Text(
                    'DONATOR',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      color: Colors.white,
                      fontSize: 22.0,
                      letterSpacing: 3.5,
                      fontWeight: FontWeight.normal,
                    ),
                  )),
                ),
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DonatorLoginScreen(),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 20.0,
              width: 150.0,
              child: Divider(
                color: Colors.black12,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: Container(
                  width: double.infinity,
                  decoration: new BoxDecoration(
                      color: Color.fromARGB(255, 19, 102, 209),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  padding: EdgeInsets.all(30),
                  child: Center(
                      child: Text(
                    'NGO',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      color: Colors.white,
                      fontSize: 22.0,
                      letterSpacing: 3.5,
                      fontWeight: FontWeight.normal,
                    ),
                  )),
                ),
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NgoLoginScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
