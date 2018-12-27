import 'package:flutter/material.dart';

import 'package:here/views/screens/location_page.dart';
import 'package:here/views/screens/map_page.dart';
import 'package:here/views/components/poi_bottom_sheet.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage> {

  PageController _pageController;
  int _page = 0;

  @override
    void initState() {
      _pageController = PageController();
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Here"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () { 
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return PoiBottomSheet();
            }
          );
        },
        tooltip: "Place of Interests",
        child: Icon(Icons.location_city),
        elevation: 2.0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _navigationTapped,
        currentIndex: _page,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            title: Text("Location")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text("Maps"),
          ),
        ]
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: <Widget>[
          LocationPage(),
          MapPage(),
        ]
      ),
    );
  }

  void _navigationTapped(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _onPageChanged(int page) => setState(() => this._page = page);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

