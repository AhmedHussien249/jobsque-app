import 'package:flutter/material.dart';
import 'package:jobsque/features/home/presentation/widgets/home_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: HomeBody()),
      bottomNavigationBar: HomeBottomNavBar(),
    );
  }
}

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Color(0xFF3366FF),
      unselectedItemColor: Colors.grey,
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: "Messages"),
        BottomNavigationBarItem(icon: Icon(Icons.work), label: "Applied"),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Saved"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
