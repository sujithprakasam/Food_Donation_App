import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarp_app/ngo/gloabalvariables.dart';

class NgoScreenLayout extends StatefulWidget {
  const NgoScreenLayout({Key? key}) : super(key: key);

  @override
  _NgoScreenLayoutState createState() => _NgoScreenLayoutState();
}

class _NgoScreenLayoutState extends State<NgoScreenLayout> {
  int _page = 0;

  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: ngoScreenItems,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.bag_fill_badge_plus,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.person,
            ),
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
        backgroundColor: Colors.blue,
        activeColor: Colors.white,
        inactiveColor: Colors.white60,
        iconSize: 29,
        border: Border(
          top: BorderSide(color: Colors.blue),
        ),
        height: 53,
      ),
    );
  }
}
