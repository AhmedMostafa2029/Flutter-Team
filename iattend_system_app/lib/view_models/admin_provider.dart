import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../core/api/dio_helper.dart';
import '../core/api/end_points.dart';

class AdminProvider extends ChangeNotifier {
  bool isLoading = false;
  File? studentImage; // لتخزين صورة الطالب المختارة

  // =================================================
  // 📸 وظيفة: اختيار صورة الطالب من المعرض
  // =================================================
  Future<void> pickStudentImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      studentImage = File(pickedFile.path);
      notifyListeners(); // تحديث الواجهة لعرض الصورة
    }
  }

  // =================================================
  // 1️⃣ وظيفة: تسجيل طالب جديد
  // =================================================
  Future<void> registerStudent({
    required String name,
    required String email,    // الكود الجامعي (كـ Username)
    required String password,
    required String uniId,    // الرقم الجامعي للداتابيز
    required BuildContext context,
  }) async {
    // التحقق من اختيار الصورة
    if (studentImage == null) {
      Fluttertoast.showToast(msg: "يرجى اختيار صورة للطالب 📸", backgroundColor: Colors.red);
      return;
    }

    _setLoading(true);

    try {
      String fileName = studentImage!.path.split('/').last;
      
      // تجهيز البيانات كـ FormData (لأننا بنرفع ملف)
      FormData formData = FormData.fromMap({
        "name": name,
        "email": email,
        "password": password,
        "university_id": uniId,
        "file": await MultipartFile.fromFile(studentImage!.path, filename: fileName),
      });

      await DioHelper.postData(
        url: EndPoints.registerStudent, 
        data: formData,
      );
      
      Fluttertoast.showToast(msg: "تم تسجيل الطالب بنجاح ✅", backgroundColor: Colors.green);
      
      // تنظيف البيانات والرجوع
      studentImage = null;
      Navigator.pop(context); 

    } catch (e) {
      _handleError(e);
    }
    
    _setLoading(false);
  }

  // =================================================
  // 2️⃣ وظيفة: تسجيل دكتور جديد
  // =================================================
  Future<void> registerDoctor({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String dept,
    required BuildContext context,
  }) async {
    _setLoading(true);

    try {
      FormData formData = FormData.fromMap({
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "department": dept,
      });

      await DioHelper.postData(
        url: EndPoints.registerDoctor, 
        data: formData,
      );
      
      Fluttertoast.showToast(msg: "تم تسجيل الدكتور بنجاح ✅", backgroundColor: Colors.green);
      Navigator.pop(context);

    } catch (e) {
      _handleError(e);
    }

    _setLoading(false);
  }

  // =================================================
  // 3️⃣ وظيفة: إضافة مادة جديدة
  // =================================================
  Future<void> addSubject({
    required String name,
    required String code,
    required String docEmail, // إيميل الدكتور للربط
    required BuildContext context,
  }) async {
    _setLoading(true);

    try {
      FormData formData = FormData.fromMap({
        "name": name,
        "code": code,
        "doctor_email": docEmail,
      });

      await DioHelper.postData(
        url: EndPoints.addSubject, 
        data: formData,
      );
      
      Fluttertoast.showToast(msg: "تم إضافة المادة بنجاح ✅", backgroundColor: Colors.green);
      Navigator.pop(context);

    } catch (e) {
      _handleError(e);
    }

    _setLoading(false);
  }

  // =================================================
  // 4️⃣ وظيفة: ربط طالب بمادة (Enrollment)
  // =================================================
  Future<void> enrollStudent({
    required String uniId,
    required String subCode,
    required BuildContext context,
  }) async {
    _setLoading(true);

    try {
      FormData formData = FormData.fromMap({
        "university_id": uniId,
        "subject_code": subCode,
      });

      await DioHelper.postData(
        url: EndPoints.enrollStudent, 
        data: formData,
      );
      
      Fluttertoast.showToast(msg: "تم الربط بنجاح ✅", backgroundColor: Colors.green);
      Navigator.pop(context);

    } catch (e) {
      _handleError(e);
    }

    _setLoading(false);
  }

  // =================================================
  // 🛠️ دوال مساعدة داخلية (Helpers)
  // =================================================
  
  // لتغيير حالة التحميل وتحديث الشاشة
  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  // لمعالجة الأخطاء وعرض الرسائل المناسبة
  void _handleError(dynamic e) {
    print(e); // للطباعة في الكونسول للمطور
    
    if (e is DioException) {
      // لو الخطأ جاي من السيرفر (زي: الطالب مسجل مسبقاً)
      String msg = e.response?.data['message'] ?? "حدث خطأ في الاتصال";
      Fluttertoast.showToast(msg: "❌ $msg", backgroundColor: Colors.red);
    } else {
      // خطأ غير متوقع
      Fluttertoast.showToast(msg: "❌ حدث خطأ غير متوقع", backgroundColor: Colors.red);
    }
  }
}