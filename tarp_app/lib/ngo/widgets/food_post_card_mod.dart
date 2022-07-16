import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tarp_app/donator/screens/food_active_screen.dart';
import 'package:tarp_app/donator/screens/food_completed_screen.dart';
import 'package:tarp_app/ngo/screens/food_details_active_screen.dart';
import 'package:tarp_app/ngo/screens/food_details_completed_screen.dart';

class NFoodPostCardMod extends StatefulWidget {
  final snap;
  final String status;
  final String what;
  final String who;
  const NFoodPostCardMod(
      {Key? key,
      required this.snap,
      required this.status,
      required this.what,
      required this.who})
      : super(key: key);

  @override
  State<NFoodPostCardMod> createState() => _NFoodPostCardModState();
}

class _NFoodPostCardModState extends State<NFoodPostCardMod> {
  ngonamedisp() {
    if (widget.who == 'donators') {
      return Row(
        children: [
          Text(
            'Ngo Name:',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(widget.snap['ngoname']),
        ],
      );
    }
    return Container();
  }

  timename() {
    if (widget.status == 'active') {
      return Row(
        children: [
          Text(
            'Estimated Pick Up Time:',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(widget.snap['datepicked']),
        ],
      );
    }
    return Row(
      children: [
        Text(
          'Date Picked:',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          DateFormat.yMMMd().format(
            DateTime.parse(widget.snap['datepicked']),
          ),
        ),
      ],
    );
  }

  screennav() {
    if (widget.who == 'ngo') {
      if (widget.status == 'active') {
        return FoodDetailsActiveScreen(
          postId: widget.snap['postId'],
          ngoId: widget.snap['ngoId'],
          donatorId: widget.snap['donatoruid'],
        );
      } else {
        return NFoodDetailsCompletedScreen(
          donatorId: widget.snap['donatoruid'],
          ngoId: widget.snap['ngoId'],
          postId: widget.snap['postId'],
        );
      }
    } else {
      if (widget.status == 'active') {
        return DActiveScreen(
          postId: widget.snap['postId'],
          donatorId: widget.snap['donatoruid'],
          ngoId: widget.snap['ngoId'],
        );
      } else {
        return NCompletedScreen(
          postId: widget.snap['postId'],
          donatorId: widget.snap['donatoruid'],
          ngoId: widget.snap['ngoId'],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => screennav(),
        ),
      ),
      child: Container(
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(20),
          child: Container(
              padding:
                  EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 140.0,
                        width: 120.0,
                        margin: EdgeInsets.only(right: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Hero(
                            tag: "temp",
                            child: Image.network(
                              widget.snap['foodphotoUrl'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Wrap(
                        spacing: 10.0, // gap between adjacent chips
                        runSpacing: 4.0, // gap between lines
                        direction: Axis.vertical,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Text(
                              widget.snap['title'].toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                              maxLines: 2,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Text(
                              widget.snap['description'],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.black45),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 10.0,
                              ),
                              Icon(
                                Icons.timer,
                                color: Colors.blue,
                              ),
                              Text(
                                widget.snap['timecooked'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 10.0,
                              ),
                              Icon(
                                Icons.location_city,
                                color: Colors.blue,
                              ),
                              Text(
                                widget.snap['lcity'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.black45),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      Text(
                        'PickUp Information',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ngonamedisp(),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            'Volunteer Name:',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(widget.snap['volunteername']),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      timename(),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
