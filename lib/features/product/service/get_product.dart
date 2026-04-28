import 'package:chicly_store/features/product/model/product_model.dart';
import 'package:dio/dio.dart';

class GetProduct {
  final Dio dio;

  GetProduct(this.dio);
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dio.get(
        'https://api.escuelajs.co/api/v1/products',
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data; 
        return data.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products $e');
    }
  }
}
