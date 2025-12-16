import 'package:flutter/material.dart';
import '../core/api/dio_helper.dart';
import '../core/api/end_points.dart';

class StudentProvider extends ChangeNotifier {
  List<dynamic> summaryList = [];
  bool isLoading = false;
  String errorMsg = '';

  Future<void> getSummary() async {
    isLoading = true;
    errorMsg = '';
    notifyListeners();

    try {
      final response = await DioHelper.getData(url: EndPoints.studentSummary);
      summaryList = response.data; // الداتا راجعة كـ List
    } catch (e) {
      errorMsg = 'فشل تحميل البيانات';
      print(e);
    }

    isLoading = false;
    notifyListeners();
  }
}