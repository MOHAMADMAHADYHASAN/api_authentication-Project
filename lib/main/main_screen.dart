import 'package:authenticationfire/ui/posts/add_post_Screen.dart';
import 'package:authenticationfire/ui/posts/Product_screen.dart';
import 'package:authenticationfire/ui/posts/post_screen.dart';
import 'package:flutter/material.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const PostScreen(),
    const MarketplaceScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      body: _pages[_selectedIndex],

      // ================== CUSTOM (Middle Button) ==================
      floatingActionButton: Container(
        // সাইজ একটু কমিয়ে 60 করা হলো (আগে 65 ছিল)
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // Gradient বাদ দিয়ে সলিড কালার ব্যবহার করা হলো
          color: Colors.blueAccent,

          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.3), // অপাসিটি কমানো হলো
              spreadRadius: 1, // ছড়িয়ে পড়া কমানো হলো (4 থেকে 1)
              blurRadius: 8,   // ঝাপসা ভাব সামান্য কমানো হলো (10 থেকে 8)
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddPostScreen()),
            );
          },
          // আইকন সাইজ একটু কমানো হলো (32 থেকে 30)
          child: const Icon(Icons.add_rounded, size: 30, color: Colors.white),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // ================== CUSTOM BOTTOM NAVIGATION BAR ==================
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 15,
              offset:  Offset(0, -3),
            ),
          ],
        ),
        child: BottomAppBar(
          shape:  CircularNotchedRectangle(),
          notchMargin: 5.0,
          color: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          height: 70,
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // --- Home Tab ---
            CustomTabItem(
                index: 0,
                icon: Icons.home_rounded,
                label: "Home",
              ),


              const SizedBox(width: 40),

              // --- Market Tab ---
              CustomTabItem(
                index: 1,
                icon: Icons.storefront_rounded,
                label: "Market",
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================== custom icon widget ==================
  Widget CustomTabItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = _selectedIndex == index;

    return InkWell(
      onTap: () => _onItemTapped(index),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Animation
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              height: isSelected ? 28 : 24,
              width: isSelected ? 28 : 24,
              child: Icon(
                icon,
                color: isSelected ? Colors.blueAccent : Colors.grey.shade400,
                size: isSelected ? 28 : 24,
              ),
            ),
            const SizedBox(height: 4),
            // Text Animation
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                color: isSelected ? Colors.blueAccent : Colors.grey.shade400,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}