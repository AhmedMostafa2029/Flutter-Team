import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../core/api/dio_helper.dart';
import '../core/api/end_points.dart';

class DoctorProvider extends ChangeNotifier {
  List<dynamic> subjects = [];
  String? selectedSubjectId;
  File? selectedImage;
  bool isLoading = false;
  List<dynamic> attendanceResult = [];

  // 1. جلب المواد للدوربداون
  Future<void> getSubjects() async {
    try {
      final response = await DioHelper.getData(url: EndPoints.subjects);
      subjects = response.data;
      notifyListeners();
    } catch (e) {
      print("Error loading subjects: $e");
    }
  }

  // 2. التقاط صورة
  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  // 3. إرسال الصورة للسيرفر
  Future<void> uploadAttendance() async {
    if (selectedImage == null || selectedSubjectId == null) {
      Fluttertoast.showToast(msg: "يرجى اختيار المادة والصورة أولاً", backgroundColor: Colors.red);
      return;
    }

    isLoading = true;
    attendanceResult = []; // تصفير النتائج القديمة
    notifyListeners();

    try {
      // تجهيز الصورة كـ FormData
      String fileName = selectedImage!.path.split('/').last;
      FormData formData = FormData.fromMap({
        "subject_id": selectedSubjectId,
        "file": await MultipartFile.fromFile(selectedImage!.path, filename: fileName),
      });

      final response = await DioHelper.postData(
        url: EndPoints.recognize,
        data: formData,
      );

      // تخزين النتيجة لعرضها
      if (response.data['people'] != null) {
        attendanceResult = response.data['people'];
        Fluttertoast.showToast(msg: "تم تحليل الصورة بنجاح", backgroundColor: Colors.green);
      } else {
         Fluttertoast.showToast(msg: "لم يتم التعرف على أحد", backgroundColor: Colors.orange);
      }

    } catch (e) {
      print("Upload Error: $e");
      Fluttertoast.showToast(msg: "حدث خطأ أثناء الرفع", backgroundColor: Colors.red);
    }

    isLoading = false;
    notifyListeners();
  }
}