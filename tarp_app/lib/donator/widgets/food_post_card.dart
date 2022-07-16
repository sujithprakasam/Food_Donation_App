import 'package:flutter/material.dart';
import 'package:tarp_app/donator/screens/food_details_screen.dart';

class FoodPostCard extends StatefulWidget {
  final snap;
  const FoodPostCard({Key? key, this.snap}) : super(key: key);

  @override
  State<FoodPostCard> createState() => _FoodPostCardState();
}

class _FoodPostCardState extends State<FoodPostCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FoodDetailScreen(
            postId: widget.snap['postId'],
          ),
        ),
      ),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Row(
              children: [
                Container(
                  height: 140.0,
                  width: 120.0,
                  margin: EdgeInsets.only(right: 10),
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
            )),
      ),
    );
  }
}
