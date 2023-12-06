import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/discover/views/discover_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../routes/app_pages.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black.withAlpha(100),
      items: [
        BottomNavigationBarItem(
          icon: Container(
            margin: const EdgeInsets.only(left: 50),
            child: IconButton(
              onPressed: () {
                // Get.toNamed(Routes.HOME);
                Get.to(() => const HomeView());
              },
              icon: const Icon(Icons.home),
            ),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {
              // Get.toNamed(Routes.DISCOVER);
              Get.to(() => const DiscoverView());
            },
            icon: const Icon(Icons.search),
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Container(
            margin: const EdgeInsets.only(right: 50),
            child: IconButton(
              onPressed: () {
                // Get.toNamed(Routes.PROFILE);
                Get.to(() => const ProfileView());
              },
              icon: const Icon(Icons.person),
            ),
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
