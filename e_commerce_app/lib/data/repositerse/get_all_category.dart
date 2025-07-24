
import 'package:e_commerce_app/data/models/product_model.dart';
import 'package:e_commerce_app/data/services/product_services.dart';

class GetAllCategory {
  final ProductServices productServices = ProductServices();

  Future<List<ProductModel>> getAllProducts() async {
    try {
      final raw = await productServices.getAllProducts();

      if (raw is List) {
        return raw
            .whereType<Map<String, dynamic>>()
            .map((e) => ProductModel.fromJson(e))
            .toList();
      } else {
        print('Unexpected data format from API: $raw');
        return [];
      }
    } catch (e, stackTrace) {
      print('Error in GetAllCategory.getAllProducts: $e');
      print(stackTrace);
      return [];
    }
  }
}
