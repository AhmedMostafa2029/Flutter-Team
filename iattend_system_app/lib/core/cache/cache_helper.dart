import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  // تهيئة المكتبة عند فتح التطبيق
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // حفظ بيانات (توكن، دور، اسم)
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    return await sharedPreferences.setDouble(key, value);
  }

  // استرجاع بيانات
  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  // حذف بيانات (عند تسجيل الخروج)
  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }
  
  // مسح كل شيء (Clear Cache)
  static Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }
}