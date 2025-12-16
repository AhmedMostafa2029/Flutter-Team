import 'package:dio/dio.dart';
import '../cache/cache_helper.dart';

class DioHelper {
  static late Dio dio;

  // 1. تهيئة Dio مرة واحدة عند فتح التطبيق
  static void init() {
    dio = Dio(
      BaseOptions(
        // ⚠️ هام: لو بتجرب على الموبايل، استخدم IP جهاز الكمبيوتر (Run > ipconfig)
        // مثال: 'http://192.168.1.5:8000'
        // لو Emulator استخدم: 'http://10.0.2.2:8000'
        // baseUrl: 'http://192.168.1.10:8000', 
        baseUrl: '192.168.1.7', 
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  // 2. دالة لجلب البيانات (GET)
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    bool needsToken = true, // هل الرابط محتاج توكن؟
  }) async {
    _setHeaders(needsToken);
    return await dio.get(url, queryParameters: query);
  }

  // 3. دالة لإرسال البيانات (POST) - تدعم ملفات وصور
  static Future<Response> postData({
    required String url,
    required dynamic data, // يقبل JSON أو FormData
    Map<String, dynamic>? query,
    bool needsToken = true,
  }) async {
    _setHeaders(needsToken);
    return await dio.post(url, queryParameters: query, data: data);
  }

  // 4. وضع التوكن في الهيدر أوتوماتيك
  static void _setHeaders(bool needsToken) {
    dio.options.headers = {
      'Content-Type': 'application/json', // أو multipart لو فيه صور Dio بيظبطها
    };
    if (needsToken) {
      String? token = CacheHelper.getData(key: 'token');
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }
    }
  }
}