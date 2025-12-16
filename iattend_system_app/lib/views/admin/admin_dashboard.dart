import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/auth_provider.dart';
import 'add_doctor_screen.dart';
import 'add_subject_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("لوحة الإدارة"),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(onPressed: () => Provider.of<AuthProvider>(context, listen: false).logout(context), icon: const Icon(Icons.logout))
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: [
          _buildCard(Icons.person_add, "إضافة طالب", Colors.blue, () {}),
          _buildCard(Icons.link, "ربط مادة", Colors.purple, () {}),
          _buildCard(Icons.school, "إضافة دكتور", Colors.orange, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => AddDoctorScreen()));
            }),
          _buildCard(Icons.book, "إضافة مادة", Colors.green, () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => AddSubjectScreen()));
            }),
        ],
      ),
    );
  }

  Widget _buildCard(IconData icon, String title, Color color, VoidCallback onTap) {
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
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}