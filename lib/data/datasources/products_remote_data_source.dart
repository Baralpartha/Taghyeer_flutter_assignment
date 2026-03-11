import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';
import '../models/product_model.dart';

class ProductsRemoteDataSource {
  final DioClient client;
  ProductsRemoteDataSource(this.client);

  Future<List<ProductModel>> getProducts({
    required int limit,
    required int skip,
  }) async {
    final response = await client.get(
      ApiConstants.products,
      queryParameters: {'limit': limit, 'skip': skip},
    );

    final List products = response.data['products'] ?? [];
    return products.map((e) => ProductModel.fromJson(e)).toList();
  }
}