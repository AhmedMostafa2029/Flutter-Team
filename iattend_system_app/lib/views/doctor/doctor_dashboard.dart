import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../view_models/doctor_provider.dart';
import '../../view_models/auth_provider.dart';
import '../../core/cache/cache_helper.dart'; // استدعاء الكاش

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({super.key});

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  // متغيرات بيانات الدكتور
  String doctorName = "";
  String doctorEmail = "";

  @override
  void initState() {
    super.initState();
    _loadDoctorData(); // تحميل بيانات الدكتور
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // الـ Provider هيجيب المواد، وبسبب تعديل الباك اند هتيجي مواد الدكتور ده بس
      Provider.of<DoctorProvider>(context, listen: false).getSubjects();
    });
  }

  void _loadDoctorData() {
    setState(() {
      doctorName = CacheHelper.getData(key: 'name') ?? "دكتور";
      doctorEmail = CacheHelper.getData(key: 'email') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    var doctorProvider = Provider.of<DoctorProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("نظام الحضور الذكي"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
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
            // -----------------------------
            // 1. كارت بيانات الدكتور (الجديد)
            // -----------------------------
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(color: Colors.indigo.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))
                ],
              ),
              child: Row(
                children: [
                   CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.indigo[100],
                    child: const Icon(Icons.person, size: 35, color: Colors.indigo),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("أهلاً، د. $doctorName", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(doctorEmail, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // -----------------------------
            // 2. اختيار المادة
            // -----------------------------
            const Text("المادة الدراسية:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: doctorProvider.selectedSubjectId,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.indigo),
                  items: doctorProvider.subjects.isEmpty 
                      ? [] 
                      : doctorProvider.subjects.map((sub) {
                    return DropdownMenuItem<String>(
                      value: sub['id'].toString(),
                      child: Text(sub['name'], style: const TextStyle(fontSize: 16)),
                    );
                  }).toList(),
                  onChanged: (val) => doctorProvider.selectedSubjectId = val,
                  hint: doctorProvider.subjects.isEmpty 
                      ? const Text("جاري تحميل المواد...") 
                      : const Text("اختر المادة لتسجيل الحضور"),
                ),
              ),
            ),
            
            const SizedBox(height: 20),

            // -----------------------------
            // 3. منطقة الصورة
            // -----------------------------
            GestureDetector(
              onTap: () => _showPicker(context, doctorProvider),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.indigo[50],
                  border: Border.all(color: Colors.indigo.withOpacity(0.3), width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: doctorProvider.selectedImage == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_enhance, size: 60, color: Colors.indigo[300]),
                          const SizedBox(height: 10),
                          Text("اضغط لالتقاط صورة القاعة", style: TextStyle(color: Colors.indigo[800], fontWeight: FontWeight.bold)),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Image.file(doctorProvider.selectedImage!, fit: BoxFit.cover),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            // -----------------------------
            // 4. زر الرفع
            // -----------------------------
            ElevatedButton.icon(
              onPressed: doctorProvider.isLoading ? null : () => doctorProvider.uploadAttendance(),
              icon: doctorProvider.isLoading 
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) 
                  : const Icon(Icons.cloud_upload),
              label: const Text("تحليل الحضور وتسجيل الغياب"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),

            const SizedBox(height: 20),
            if (doctorProvider.attendanceResult.isNotEmpty) const Divider(thickness: 2),

            // -----------------------------
            // 5. عرض النتائج (محدث بالرقم الجامعي)
            // -----------------------------
            if (doctorProvider.attendanceResult.isNotEmpty) ...[
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("نتائج التحليل:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: Colors.green[100], borderRadius: BorderRadius.circular(20)),
                    child: Text("تم التعرف على: ${doctorProvider.attendanceResult.length}", style: TextStyle(color: Colors.green[800], fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              const SizedBox(height: 10),
              
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: doctorProvider.attendanceResult.length,
                itemBuilder: (context, index) {
                  var student = doctorProvider.attendanceResult[index];
                  // فحص الحالة
                  bool isSuccess = student['status'] == 'Success' || student['status'] == 'Skipped';
                  bool isSkipped = student['status'] == 'Skipped';
                  
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: isSuccess ? (isSkipped ? Colors.orange[100] : Colors.green[100]) : Colors.red[100],
                        child: Icon(
                          isSuccess ? (isSkipped ? Icons.history : Icons.check) : Icons.close,
                          color: isSuccess ? (isSkipped ? Colors.orange : Colors.green) : Colors.red,
                        ),
                      ),
                      title: Text(student['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // عرض الرقم الجامعي هنا
                          Text("ID: ${student['university_id'] ?? '---'}", style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.blueGrey)),
                          Text(student['msg'], style: TextStyle(color: isSuccess ? Colors.green : Colors.red, fontSize: 12)),
                        ],
                      ),
                    ),
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
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.indigo),
              title: const Text('اختيار من المعرض'),
              onTap: () {
                provider.pickImage(ImageSource.gallery);
                Navigator.of(ctx).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera, color: Colors.indigo),
              title: const Text('التقاط صورة'),
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