import 'package:flutter/material.dart';
import 'package:pizza_delivery/pages/auth_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const AuthPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.redAccent, Colors.white],
                ),
              ),
            ),
          ),
          // Pizza Image
          Positioned(
            bottom: -40,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/ic_welcome_screen.png',
              fit: BoxFit.fitWidth,
              height: 1000, // Ukuran gambar diperkecil
              alignment: Alignment.bottomCenter,
            ),
          ),
          // Text dan Header
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/logo.png',
                    height: 50,
                  ),
                ),
                const SizedBox(height: 100),
                // Title Text
                const Text(
                  "FAST",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF800000),
                  ),
                ),
                const Text(
                  "FOOD",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF800000),
                  ),
                ),
                const Text(
                  "FAST",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF800000),
                  ),
                ),
                const Text(
                  "DELIVERY",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF800000),
                  ),
                ),
              ],
            ),
          ),
          // Sign In / Sign Up Button di kanan atas
          Positioned(
            top: 60,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthPage()),
                ),
              child: const Text(
                "Sign In/Sign Up",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
