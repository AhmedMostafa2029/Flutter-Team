import 'package:flutter/material.dart';
import '../core/cache/cache_helper.dart';
import 'auth/login_screen.dart';
import 'admin/admin_dashboard.dart';
import 'doctor/doctor_dashboard.dart';
import 'student/student_dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  void _checkAuth() async {
    await Future.delayed(const Duration(seconds: 2)); // شكل جمالي
    String? token = CacheHelper.getData(key: 'token');
    String? role = CacheHelper.getData(key: 'role');

    Widget nextScreen = LoginScreen();

    if (token != null) {
      if (role == 'Admin') nextScreen = const AdminDashboard();
      else if (role == 'Doctor') nextScreen = const DoctorDashboard();
      else if (role == 'Student') nextScreen = const StudentDashboard();
    }

    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => nextScreen)
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt, size: 80, color: Colors.white),
            SizedBox(height: 20),
            Text("VisionLog", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}