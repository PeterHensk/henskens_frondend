import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  CustomBottomNavigationBar({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    int index = currentIndex;

    final routeName = ModalRoute.of(context)!.settings.name;

    if (routeName == '/arDino') {
      index = 1;
    } else if (routeName == '/portfolio') {
      index = 2;
    }

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.accessibility_new),
          label: 'AR',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Portfolio',
        ),
      ],
      currentIndex: index,
      selectedItemColor: Colors.blue,
      onTap: (int newIndex) {
        if (newIndex == 0) {
          Navigator.pushReplacementNamed(context, '/');
        } else if (newIndex == 1) {
          Navigator.pushReplacementNamed(context, '/arDino');
        } else if (newIndex == 2) {
          Navigator.pushReplacementNamed(context, '/portfolio');
        }
      },
    );
  }
}
