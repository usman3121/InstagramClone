import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/ui/screens/insta_feed.dart';
import 'homepage_profile_screens/controller/post_controller.dart';
import '../../services/model/user_model.dart';
import 'camera_screen/camera_screen.dart';
import 'homepage_profile_screens/Views/profile_screen.dart';
import 'searchscreen/searchscreen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedIndex = 0;
  final PostController postController = Get.put(PostController());
  final UserModel users = UserModel();

  static final List<Widget> _pages = [
     const InstaFeed(),
    const SearchScreen(),
    CameraScreen(),
    const ProfileScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        postController.getUserData();

        break;
      case 4:
        postController.getUserData();
        break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.black),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined, color: Colors.black),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_outlined, color: Colors.black),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black),
            label: 'Profile',
          ),
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }
}
