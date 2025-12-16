import 'package:flutter/material.dart';
import 'package:iattend_system_app/view_models/admin_provider.dart';
import 'package:iattend_system_app/view_models/doctor_provider.dart';
import 'package:iattend_system_app/view_models/student_provider.dart';
import 'package:iattend_system_app/views/splash_screen.dart';
import 'package:provider/provider.dart';
import 'core/api/dio_helper.dart';
import 'core/cache/cache_helper.dart';
import 'view_models/auth_provider.dart';
import 'views/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // تهيئة الأدوات المساعدة
  await CacheHelper.init();
  DioHelper.init();

  runApp(const VisionLogApp());
}

class VisionLogApp extends StatelessWidget {
  const VisionLogApp({super.key});

  @override
  Widget build(BuildContext context) {
      return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DoctorProvider()), 
        ChangeNotifierProvider(create: (_) => StudentProvider()), 
        ChangeNotifierProvider(create: (_) => AdminProvider()), 
      ],
      child: MaterialApp(
        title: 'VisionLog',
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: false, // عشان شكل الـ Form يبقى كلاسيك وواضح
        ),
      ),
    );
  }
}