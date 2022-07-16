import 'package:flutter/material.dart';
import 'package:tarp_app/ngo/screens/food_active_screen.dart';

class InfoCardMod extends StatelessWidget {
  final String text;
  final String status;
  final String who;
  final String what;
  const InfoCardMod({
    Key? key,
    required this.text,
    required this.status,
    required this.who,
    required this.what,
  }) : super(key: key);

  screennav() {
    return NActiveFoodScreen(
      status: status,
      what: what,
      who: who,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => screennav(),
        ),
      ),
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: ListTile(
          leading: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: "Source Sans Pro",
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
