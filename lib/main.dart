import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:d_session/d_session.dart';
import 'package:pizza_delivery/pages/discover_page.dart';
import 'package:pizza_delivery/pages/splash_screen_page.dart';
import 'package:pizza_delivery/pages/not_found_page.dart'; // Tambahkan halaman 404 jika diperlukan
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // Inisialisasi Supabase
  await Supabase.initialize(
    url: 'https://xzhwnttqotcnycohoznl.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6aHdudHRxb3Rjbnljb2hvem5sIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzUzMzUwMzQsImV4cCI6MjA1MDkxMTAzNH0.s722_iG0aJgp3c2aYOh2h0MYCWVdcda-5YHQ_k7A-68',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffFFFFFF),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: FutureBuilder(
        future: DSession.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null) return const SplashScreenPage();
          return DiscoverPage();
        },
      ),
      routes: {
        '/discover': (context) => DiscoverPage(),
        '/splash': (context) => SplashScreenPage(),
      },
      onUnknownRoute: (settings) {
        // Halaman fallback jika rute tidak ditemukan
        return MaterialPageRoute(
          builder: (context) => const NotFoundPage(),
        );
      },
    );
  }
}
