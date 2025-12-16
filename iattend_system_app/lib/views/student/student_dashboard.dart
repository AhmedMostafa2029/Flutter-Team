import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/student_provider.dart';
import '../../view_models/auth_provider.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  @override
  void initState() {
    super.initState();
    // استدعاء البيانات أول ما الشاشة تفتح
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<StudentProvider>(context, listen: false).getSummary();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("لوحة الطالب"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Provider.of<AuthProvider>(context, listen: false).logout(context),
          )
        ],
      ),
      body: Consumer<StudentProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) return const Center(child: CircularProgressIndicator());
          if (provider.errorMsg.isNotEmpty) return Center(child: Text(provider.errorMsg));
          if (provider.summaryList.isEmpty) return const Center(child: Text("لا توجد مواد مسجلة"));

          return ListView.builder(
            itemCount: provider.summaryList.length,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              final item = provider.summaryList[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: item['absent'] > 0 ? Colors.red : Colors.green,
                    child: Text("${item['attended']}", style: const TextStyle(color: Colors.white)),
                  ),
                  title: Text(item['subject'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("د. ${item['doctor']}"),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("الغياب", style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                      Text("${item['absent']} أسبوع", 
                           style: TextStyle(color: item['absent'] > 0 ? Colors.red : Colors.green, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}