
import 'package:flutter/material.dart';
import 'package:tiktok_clone/Views/Widgets/custom_icon.dart';
import 'package:tiktok_clone/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(()=> pageIndex = index);
        },
        currentIndex: pageIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 30,), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search, size: 30,), label: 'Search'),
          BottomNavigationBarItem(icon: CustomIcon(), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message, size: 30,), label: 'Message'),
          BottomNavigationBarItem(icon: Icon(Icons.person, size: 30,), label: 'Profile'),
        ],
      ),
      body: pages[pageIndex],
    );
  }
}
