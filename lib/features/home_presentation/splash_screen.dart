import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // الانتقال للصفحة الرئيسية بعد 3 ثواني
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/'); // بيروح للـ HomeScreen
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white, // اختار اللون اللي تحبه
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // حط هنا اللوجو بتاعك
            Icon(Icons.volunteer_activism, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              "Don't Waste Donate",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            CircularProgressIndicator(), // مؤشر تحميل بسيط
          ],
        ),
      ),
    );
  }
}