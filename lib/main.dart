import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/user_dashboard.dart';
import 'screens/donor_feed.dart';
import 'screens/admin_dashboard.dart';
import 'screens/donation_form.dart';

void main() {
  runApp(const HopeBridgeApp());
}

class HopeBridgeApp extends StatelessWidget {
  const HopeBridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HopeBridge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[50],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            backgroundColor: Colors.indigo,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/user-dashboard': (context) => const UserDashboard(),
        '/donor-feed': (context) => const DonorFeed(),
        '/admin-dashboard': (context) => const AdminDashboard(),
        '/donation-form': (context) => const DonationForm(),
      },
    );
  }
}
