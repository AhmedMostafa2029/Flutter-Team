import 'dart:io'; // عشان ملف الصور
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../core/api/dio_helper.dart';

class AdminProvider extends ChangeNotifier {
  bool isLoading = false;

  // ----------------------------------------------------------------
  // 1. تسجيل طالب (مع رفع الصورة)
  // Endpoint: /register/student
  // Python Params: name, email, password, university_id, file
  // ----------------------------------------------------------------
  Future<void> registerStudent({
    required String name,
    required String email,
    required String password,
    required String universityId,
    required File imageFile, // لازم نستقبل ملف الصورة
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      // تجهيز البيانات كـ FormData عشان فيه صورة
      FormData formData = FormData.fromMap({
        'name': name,
        'email': email,
        'password': password,
        'university_id': universityId, // لازم تكون university_id زي البايثون
        'file': await MultipartFile.fromFile(imageFile.path, filename: "student_face.jpg"),
      });

      final response = await DioHelper.postData(
        url: '/register/student',
        data: formData,
        needsToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(msg: "✅ تم تسجيل الطالب وحفظ البصمة", backgroundColor: Colors.green);
        Navigator.pop(context);
      }
    } catch (e) {
      handleError(e);
    }

    isLoading = false;
    notifyListeners();
  }

  // ----------------------------------------------------------------
  // 2. تسجيل دكتور
  // Endpoint: /register/doctor
  // Python Params: name, email, password, phone, department
  // ----------------------------------------------------------------
  Future<void> registerDoctor({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String dept,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      // الـ API بيستخدم Form(...) فلازم نبعت FormData
      FormData formData = FormData.fromMap({
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'department': dept,
      });

      final response = await DioHelper.postData(
        url: '/register/doctor',
        data: formData,
        needsToken: true,
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "✅ تم تسجيل الدكتور بنجاح", backgroundColor: Colors.green);
        Navigator.pop(context);
      }
    } catch (e) {
      handleError(e);
    }

    isLoading = false;
    notifyListeners();
  }

  // ----------------------------------------------------------------
  // 3. إضافة مادة
  // Endpoint: /admin/subjects
  // Python Params: name, code, doctor_email
  // ----------------------------------------------------------------
  Future<void> addSubject({
    required String name,
    required String code,
    required String docEmail,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      FormData formData = FormData.fromMap({
        'name': name,
        'code': code,
        'doctor_email': docEmail,
      });

      final response = await DioHelper.postData(
        url: '/admin/subjects',
        data: formData,
        needsToken: true,
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "✅ تم إضافة المادة بنجاح", backgroundColor: Colors.green);
        Navigator.pop(context);
      }
    } catch (e) {
      handleError(e);
    }

    isLoading = false;
    notifyListeners();
  }

  // ----------------------------------------------------------------
  // 4. تسجيل طالب في مادة (Enroll)
  // Endpoint: /admin/enroll
  // Python Params: university_id, subject_code
  // ----------------------------------------------------------------
  Future<void> enrollStudent({
    required String universityId,
    required String subjectCode,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      FormData formData = FormData.fromMap({
        'university_id': universityId,
        'subject_code': subjectCode,
      });

      final response = await DioHelper.postData(
        url: '/admin/enroll',
        data: formData,
        needsToken: true,
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "✅ تم ربط الطالب بالمادة", backgroundColor: Colors.green);
        Navigator.pop(context);
      }
    } catch (e) {
      handleError(e);
    }

    isLoading = false;
    notifyListeners();
  }

  // دالة مساعدة لمعالجة الأخطاء
  void handleError(dynamic e) {
    String msg = "حدث خطأ غير متوقع";
    if (e is DioException) {
      if (e.response != null && e.response?.data != null) {
        // الباك اند بيرجع الرسالة يا أما في 'detail' أو 'message'
        msg = e.response?.data['detail'] ?? e.response?.data['message'] ?? msg;
      }
    }
    print("❌ Error: $e");
    Fluttertoast.showToast(msg: "خطأ: $msg", backgroundColor: Colors.red);
  }

  // ----------------------------------------------------------------
  // 5. تغيير باسورد مستخدم (Admin Reset Password)
  // Endpoint: /admin/reset-password
  // ----------------------------------------------------------------
  Future<void> resetUserPassword({
    required String email,
    required String newPassword,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      FormData formData = FormData.fromMap({
        'email': email,
        'new_password': newPassword,
      });

      final response = await DioHelper.postData(
        url: '/admin/reset-password',
        data: formData,
        needsToken: true,
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "✅ تم تغيير كلمة المرور بنجاح", backgroundColor: Colors.green);
        Navigator.pop(context); // نرجع للوحة التحكم
      }
    } catch (e) {
      handleError(e);
    }

    isLoading = false;
    notifyListeners();
  }
}