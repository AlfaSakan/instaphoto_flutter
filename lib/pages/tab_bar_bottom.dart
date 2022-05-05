import 'package:flutter/material.dart';
import 'package:instaphoto_flutter/pages/pages.dart';

class TabBarBottom extends StatefulWidget {
  static const routeName = 'TabBarBottom';
  const TabBarBottom({Key? key}) : super(key: key);

  @override
  State<TabBarBottom> createState() => _TabBarBottomState();
}

class _TabBarBottomState extends State<TabBarBottom> {
  int tabIndex = 0;
  List<Widget> listScreens = const [
    HomePage(),
    SearchPage(),
    AddPhotoPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listScreens[tabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        onTap: (index) {
          setState(() {
            tabIndex = index;
          });
        },
        iconSize: 26,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedFontSize: 26,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_a_photo,
              color: Colors.black,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
