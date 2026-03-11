// product_repository_impl.dart
import '../../core/utils/result.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/products_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductsRemoteDataSource remote;
  ProductRepositoryImpl(this.remote);

  @override
  Future<Result<List<ProductEntity>>> getProducts({
    required int limit,
    required int skip,
  }) async {
    try {
      final res = await remote.getProducts(limit: limit, skip: skip);
      return Result.success(res);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}