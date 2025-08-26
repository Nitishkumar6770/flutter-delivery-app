import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
import 'package:bitebuddie_new_version/features/home/presentation/pages/homepage.dart';
import 'package:bitebuddie_new_version/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavigationButton extends StatefulWidget {
  const NavigationButton({super.key});

  @override
  State<NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  final List<Widget> _pages = [
    const HomePage(),
    Container(
      color: Colors.amber,
      child: Center(
        child: Text(
          'OrdersPage',
          style: TextStyle(
            color: Colors.white,
            fontSize: 34.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    ProfilePage(),
  ];
  int currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTabTapped,
        backgroundColor: ColorsPalette.white,
        selectedItemColor: ColorsPalette.red,
        unselectedItemColor: ColorsPalette.black,
        iconSize: 24,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13.sp,
        ),
        unselectedLabelStyle: TextStyle(fontSize: 12.sp),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
