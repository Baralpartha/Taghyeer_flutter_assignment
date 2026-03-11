import '../../core/utils/result.dart';
import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<Result<List<ProductEntity>>> getProducts({
    required int limit,
    required int skip,
  });
}