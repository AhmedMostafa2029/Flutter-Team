import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iattend_system_app/views/admin/admin_dashboard.dart';
import 'package:iattend_system_app/views/auth/login_screen.dart';
import 'package:iattend_system_app/views/doctor/doctor_dashboard.dart';
import 'package:iattend_system_app/views/student/student_dashboard.dart';
import '../core/api/dio_helper.dart';
import '../core/api/end_points.dart';
import '../core/cache/cache_helper.dart';
import 'package:dio/dio.dart'; // ضروري عشان نستخدم FormData

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;

  // دالة تسجيل الدخول
  Future<void> login({
    required String email,
    required String password,
    required BuildContext context, // عشان النفيجيشن
  }) async {
    isLoading = true;
    notifyListeners(); // تحديث الشاشة لإظهار اللودينج

    try {
      // 1. تجهيز البيانات كـ Form Data (لأن الباك اند متوقع x-www-form-urlencoded)
      // ملاحظة: لو الباك اند بيقبل JSON عادي، ممكن تبعت Map
      // لكن في كود الـ FastAPI الحالي احنا بنستخدم OAuth2PasswordRequestForm
      final formData = FormData.fromMap({
        'username': email,
        'password': password,
      });
      // 2. الاتصال بالسيرفر
      final response = await DioHelper.postData(
        url: EndPoints.login,
        data: formData,
        needsToken: false, // مش محتاجين توكن عشان ندخل
      );
      // 3. النجاح
      if (response.statusCode == 200) {
        var data = response.data;
        var userInfo = data['user_info'];
        String token = data['access_token'];

        // تأكد من الباك اند هل المفتاح اسمه 'role' ولا جوه 'user_info'
        // حسب الكود اللي فات كان: data['user_info']['role']
        String role = data['user_info']['role'];
        String name = data['user_info']['name'];

        // لو الطالب لسه جديد ممكن الرقم الجامعي يكون null فبنتأكد
// 1. حفظ الإيميل
        if (userInfo['email'] != null) {
           await CacheHelper.saveData(key: 'email', value: userInfo['email']);
        }

        // 2. حفظ الرقم الجامعي
        if (userInfo['university_id'] != null) {
           // لازم نحوله لـ String عشان الكاش بيحفظ String
           await CacheHelper.saveData(key: 'university_id', value: userInfo['university_id'].toString());
        } else {
           // لو دكتور مثلاً ملوش رقم جامعي، نحفظ شرطة عشان متبقاش null
           await CacheHelper.saveData(key: 'university_id', value: "---");
        }
        // حفظ البيانات
        await CacheHelper.saveData(key: 'token', value: token);
        await CacheHelper.saveData(key: 'role', value: role);
        await CacheHelper.saveData(key: 'name', value: name);

        Fluttertoast.showToast(
          msg: "مرحباً $name ($role)",
          backgroundColor: Colors.green,
        );

        // --- منطق التوجيه (Navigation Logic) ---

        // تأكد إن الـ context لسه موجود قبل النقل
        if (!context.mounted) return;

        // هنحدد الشاشة حسب الدور
        // ملاحظة: تأكد أن القيم دي (Admin, Student, Doctor) مطابقة للي راجع من الداتا بيز بالضبط (Case Sensitive)
        if (role == 'Admin' || role == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AdminDashboard()),
          );
        } else if (role == 'Student' || role == 'student') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const StudentDashboard()),
          );
        } else if (role == 'Doctor' ||
            role == 'doctor' ||
            role == 'Professor') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DoctorDashboard()),
          );
        } else {
          Fluttertoast.showToast(
            msg: "دور غير معروف: $role",
            backgroundColor: Colors.orange,
          );
        }

        print("✅ Login Success! Token: $token");
      }
    } catch (e) {
      // 4. الفشل
      print("❌ Login Error: $e");
      Fluttertoast.showToast(
        msg: "فشل تسجيل الدخول: تأكد من البيانات",
        backgroundColor: Colors.red,
      );
    }

    isLoading = false;
    notifyListeners(); // إخفاء اللودينج
  }

  // دالة تسجيل الخروج
  // دالة تسجيل الخروج
  Future<void> logout(BuildContext context) async {
    // 1. مسح البيانات المحفوظة
    await CacheHelper.clearData();

    // 2. الانتقال لصفحة تسجيل الدخول ومسح كل الصفحات السابقة من الذاكرة
    // عشان المستخدم ميدوس "رجوع" ويلاقي نفسه جوه تاني
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (route) => false, // الشرط ده بيمسح كل الصفحات اللي فاتت
    );

    // تصفير المتغيرات لو فيه حاجة محتاجة تصفير
    isLoading = false;
    notifyListeners();
  }
}
