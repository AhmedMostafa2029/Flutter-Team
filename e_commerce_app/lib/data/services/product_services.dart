import 'package:dio/dio.dart';
import 'package:e_commerce_app/consts/consts.dart';

class ProductServices {
  Dio dio = Dio();

  Future<dynamic> getAllProducts() async {
    try {
      Response response = await dio.get(baseUrl);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        print('Error: ${response.statusCode} - ${response.statusMessage}');
        return null;
      }
    } on Exception catch (e) {
      print('Error in ProductServices.getAllProducts: $e');
      return null;
    }
  }
}
