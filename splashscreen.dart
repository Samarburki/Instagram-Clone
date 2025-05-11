import 'dart:async';
import 'package:flutter/material.dart';
import 'package:instagram_series/Screens/Login/loginscreen.dart';
import 'package:instagram_series/Widgets/uihelper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  double _logoOpacity = 1.0;
  final Duration _blinkDuration = const Duration(milliseconds: 800);
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 0.2),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    Timer.periodic(_blinkDuration, (timer) {
      if (mounted) {
        setState(() {
          _logoOpacity = _logoOpacity == 1.0 ? 0.7 : 1.0;
        });
      }
    });

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
        _controller.dispose();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 241, 153, 183),
              Color.fromARGB(255, 218, 126, 156),
              Color.fromARGB(255, 209, 115, 147),
              Color.fromARGB(255, 214, 51, 105),
              Color.fromARGB(255, 190, 70, 110),
              Color.fromARGB(255, 145, 41, 76),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0], // Matched with 6 colors
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/instagram.png',
                height: 100,
                errorBuilder: (context, error, stackTrace) => 
                  const Icon(Icons.error, color: Colors.white),
              ),
              const SizedBox(height: 20),
              AnimatedOpacity(
                duration: _blinkDuration,
                opacity: _logoOpacity,
                child: SlideTransition(
                  position: _animation,
                  child: Center(
                    child: UiHelper.CustomImage(imgurl: "logo.png"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
