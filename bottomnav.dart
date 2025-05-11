import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_series/Screens/Home/homescreen.dart';
import 'package:instagram_series/Screens/Profile/profilescreen.dart';
import 'package:instagram_series/Screens/Search/searchscreen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    SearchScreen(),
    ProfileScreen()
  ];

  late final List<AnimationController> _animationControllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    _animationControllers = List<AnimationController>.generate(
      5,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
      growable: false,
    );

    _animations = _animationControllers.map(
      (controller) => Tween<double>(begin: 1.0, end: 1.2).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeOut,
        ),
      ),
    ).toList();

    _animationControllers[_currentIndex].forward();
  }

  @override
  void dispose() {
    for (final controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onTabTapped(int index) {
    _animationControllers[_currentIndex].reverse().then((_) {
      if (mounted) {
        setState(() {
          _currentIndex = index;
        });
        _animationControllers[index].forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black, // 👈 Dark background for contrast
          boxShadow: [
            BoxShadow(
              color: Colors.pinkAccent.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: Colors.white, // 👈 White for visibility
            unselectedItemColor: Colors.pinkAccent.shade100,
            selectedLabelStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.white.withOpacity(0.8),
                  blurRadius: 10,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 11,
              shadows: [
                Shadow(
                  color: Colors.pinkAccent.withOpacity(0.6),
                  blurRadius: 8,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: _onTabTapped,
            items: [
              _buildAnimatedTabItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home_filled,
                label: "Home",
                index: 0,
              ),
              _buildAnimatedTabItem(
                icon: Icons.search_outlined,
                activeIcon: Icons.search,
                label: "Search",
                index: 1,
              ),
              _buildAnimatedTabItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: "Profile",
                index: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildAnimatedTabItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    final isSelected = _currentIndex == index;

    return BottomNavigationBarItem(
      icon: ScaleTransition(
        scale: _animations[index],
        child: Icon(
          isSelected ? activeIcon : icon,
          size: 28,
          color: isSelected ? Colors.white : Colors.pinkAccent.shade100,
        ),
      ),
      label: label,
    );
  }
}
