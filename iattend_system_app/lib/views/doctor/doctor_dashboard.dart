import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../view_models/doctor_provider.dart';
import '../../view_models/auth_provider.dart';

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({super.key});

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DoctorProvider>(context, listen: false).getSubjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    var doctorProvider = Provider.of<DoctorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("تسجيل الحضور (AI)"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Provider.of<AuthProvider>(context, listen: false).logout(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. اختيار المادة
            const Text("اختر المادة:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: doctorProvider.selectedSubjectId,
              items: doctorProvider.subjects.map((sub) {
                return DropdownMenuItem<String>(
                  value: sub['id'].toString(),
                  child: Text(sub['name']),
                );
              }).toList(),
              onChanged: (val) => doctorProvider.selectedSubjectId = val,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              hint: const Text("اختر مادة..."),
            ),
            
            const SizedBox(height: 20),

            // 2. منطقة الصورة
            GestureDetector(
              onTap: () => _showPicker(context, doctorProvider),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: doctorProvider.selectedImage == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.camera_alt, size: 50, color: Colors.grey), Text("اضغط لالتقاط صورة")],
                      )
                    : Image.file(doctorProvider.selectedImage!, fit: BoxFit.cover),
              ),
            ),

            const SizedBox(height: 20),

            // 3. زر الرفع
            ElevatedButton.icon(
              onPressed: doctorProvider.isLoading ? null : () => doctorProvider.uploadAttendance(),
              icon: doctorProvider.isLoading 
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) 
                  : const Icon(Icons.cloud_upload),
              label: const Text("تحليل وتسجيل الحضور"),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(12), textStyle: const TextStyle(fontSize: 18)),
            ),

            const SizedBox(height: 20),
            const Divider(),

            // 4. عرض النتائج
            if (doctorProvider.attendanceResult.isNotEmpty) ...[
              const Text("نتائج الحضور:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: doctorProvider.attendanceResult.length,
                itemBuilder: (context, index) {
                  var student = doctorProvider.attendanceResult[index];
                  bool isSuccess = student['status'] == 'Success';
                  return ListTile(
                    leading: Icon(isSuccess ? Icons.check_circle : Icons.warning, color: isSuccess ? Colors.green : Colors.orange),
                    title: Text(student['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(student['msg']),
                  );
                },
              )
            ]
          ],
        ),
      ),
    );
  }

  void _showPicker(BuildContext context, DoctorProvider provider) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('من المعرض'),
              onTap: () {
                provider.pickImage(ImageSource.gallery);
                Navigator.of(ctx).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('الكاميرا'),
              onTap: () {
                provider.pickImage(ImageSource.camera);
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}