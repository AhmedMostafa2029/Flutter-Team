import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/student_provider.dart';
import '../../view_models/auth_provider.dart';
import '../../core/cache/cache_helper.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  String studentName = "";
  String studentEmail = "";
  String universityId = "";

  @override
  void initState() {
    super.initState();
    _loadStudentData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<StudentProvider>(context, listen: false).getSummary();
    });
  }

  void _loadStudentData() {
    setState(() {
      studentName = CacheHelper.getData(key: 'name') ?? "طالب";
      studentEmail = CacheHelper.getData(key: 'email') ?? "غير متوفر";
      universityId = CacheHelper.getData(key: 'university_id') ?? "---";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("لوحة الطالب"),
        centerTitle: true,
        backgroundColor: Colors.blue[800], // لون أتقل وأشيك
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Provider.of<AuthProvider>(
              context,
              listen: false,
            ).logout(context),
          ),
        ],
      ),
      body: Consumer<StudentProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading)
            return const Center(child: CircularProgressIndicator());
          if (provider.errorMsg.isNotEmpty)
            return Center(child: Text(provider.errorMsg));

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(), // سكرول ناعم
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // ---------------------------
                // 1. كارت بيانات الطالب
                // ---------------------------
                Container(
                  width: double.infinity, // ياخد عرض الشاشة بالكامل
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.blue[100],
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.blue[800],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        studentName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        studentEmail,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "ID: $universityId",
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "سجل الحضور للمواد:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // ---------------------------
                // 2. جدول المواد (متحسن)
                // ---------------------------
                provider.summaryList.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Text("لا توجد مواد مسجلة حالياً"),
                      )
                    : Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          // عشان الحواف المدورة
                          borderRadius: BorderRadius.circular(10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis
                                .horizontal, // السحر هنا: بيخلي الجدول يمط براحته
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth:
                                    MediaQuery.of(context).size.width - 40,
                              ), // أقل عرض هو عرض الشاشة
                              child: DataTable(
                                headingRowColor: MaterialStateProperty.all(
                                  Colors.grey[100],
                                ),
                                columnSpacing: 12, // مسافة مريحة بين العواميد
                                horizontalMargin: 15,
                                columns: const [
                                  DataColumn(
                                    label: Text(
                                      'المادة',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'الدكتور',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'حضور',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Text(
                                      'غياب',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                                rows: provider.summaryList.map((item) {
                                  return DataRow(
                                    cells: [
                                      DataCell(
                                        Text(
                                          item['subject'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      DataCell(Text(item['doctor'])),
                                      DataCell(
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.green[50],
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                          child: Text(
                                            "${item['attended']}",
                                            style: const TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: item['absent'] > 2
                                                ? Colors.red[50]
                                                : Colors.grey[100],
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                          child: Text(
                                            "${item['absent']}",
                                            style: TextStyle(
                                              color: item['absent'] > 2
                                                  ? Colors.red
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
