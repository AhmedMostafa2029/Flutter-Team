import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../core/api/dio_helper.dart';
import '../core/api/end_points.dart';
import '../core/cache/cache_helper.dart';

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
      final formData = {
        'username': email, // الـ FastAPI بيسميها username حتى لو هي ايميل
        'password': password,
      };

      // 2. الاتصال بالسيرفر
      final response = await DioHelper.postData(
        url: EndPoints.login,
        data: formData,
        needsToken: false, // مش محتاجين توكن عشان ندخل
      );

      // 3. النجاح
      if (response.statusCode == 200) {
        var data = response.data;
        String token = data['access_token'];
        String role = data['user_info']['role'];
        String name = data['user_info']['name'];

        // حفظ البيانات محلياً
        await CacheHelper.saveData(key: 'token', value: token);
        await CacheHelper.saveData(key: 'role', value: role);
        await CacheHelper.saveData(key: 'name', value: name);

        Fluttertoast.showToast(
            msg: "مرحباً $name ($role)", backgroundColor: Colors.green);

        // التوجيه حسب الدور (هنعمل الشاشات دي بعدين)
        // Navigator.pushReplacementNamed(context, role == 'Admin' ? '/admin' : ...);
        
        print("✅ Login Success! Token: $token"); // للتجربة
      }
    } catch (e) {
      // 4. الفشل
      print("❌ Login Error: $e");
      Fluttertoast.showToast(
          msg: "فشل تسجيل الدخول: تأكد من البيانات", backgroundColor: Colors.red);
    }

    isLoading = false;
    notifyListeners(); // إخفاء اللودينج
  }
  
  // دالة تسجيل الخروج
  void logout(BuildContext context) {
    CacheHelper.clearData();
    // Navigator.pushReplacementNamed(context, '/login');
  }
}