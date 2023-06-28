import 'package:flutter/material.dart';
import 'package:project_furniture/pages/chat.dart';
import 'package:project_furniture/pages/home.dart';
import 'package:project_furniture/pages/products.dart';
import 'package:project_furniture/pages/productsView.dart';
import 'package:project_furniture/pages/profile.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:project_furniture/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  
  List<Widget> halaman = [
    const HomePage(),
    const ProductsView(),
    const ChatPage(),
    const ProfilePage()
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            halaman.elementAt(_selectedIndex)
          ],
        ),
        bottomNavigationBar: SalomonBottomBar(
        onTap: (i) {
          setState(() {
            _selectedIndex = i;
          });
        },
        currentIndex: _selectedIndex,
        items: [
          SalomonBottomBarItem(
              icon: const Icon(Icons.home, color: biruHitam,),
              title: const Text("Home"),
              selectedColor: biruLangit,
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: const Icon(Icons.shopping_bag_rounded, color: biruHitam,),
              title: const Text("Shop"),
              selectedColor: biruLangit,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: const Icon(Icons.mark_unread_chat_alt_rounded, color: biruHitam,),
              title: const Text("Chat"),
              selectedColor: biruLangit,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: const Icon(Icons.person, color: biruHitam,),
              title: const Text("Profile"),
              selectedColor: biruLangit,
            ),
        ]
      ),
    );
  }
}