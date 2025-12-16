import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/auth_provider.dart';
import 'add_doctor_screen.dart';
import 'add_subject_screen.dart';
import 'add_student_screen.dart'; // <--- 1. ضفنا الـ Import ده عشان يشوف صفحة الطالب
import 'enroll_student_screen.dart';
import 'admin_reset_password_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("لوحة الإدارة"),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            onPressed: () => Provider.of<AuthProvider>(
              context,
              listen: false,
            ).logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: [
          // --- زرار إضافة طالب ---
          _buildCard(Icons.person_add, "إضافة طالب", Colors.blue, () {
            // 2. هنا عملنا الربط بصفحة الطالب
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AddStudentScreen()),
            );
          }),

          // --- زرار إضافة دكتور ---
          _buildCard(Icons.school, "إضافة دكتور", Colors.orange, () {
            // الربط بصفحة الدكتور
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AddDoctorScreen()),
            );
          }),

          // --- زرار إضافة مادة ---
          _buildCard(Icons.book, "إضافة مادة", Colors.green, () {
            // الربط بصفحة المادة
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AddSubjectScreen()),
            );
          }),

          // --- زرار ربط مادة (لسه معملناش شاشته) ---
          // ده ممكن نخليه مستقبلاً لتسجيل طالب في مادة معينة (Student_Enrollment)
          _buildCard(Icons.link, "تسجيل طالب في مادة", Colors.purple, () {
            // التعديل هنا: الانتقال لشاشة التسجيل
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => EnrollStudentScreen()),
            );
          }),
          
          _buildCard(Icons.lock_reset, "تغيير باسورد", Colors.brown, () {
             Navigator.push(context, MaterialPageRoute(builder: (_) => AdminResetPasswordScreen()));
          }),
        ],
      ),
    );
  }

  Widget _buildCard(
    IconData icon,
    String title,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 5,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
