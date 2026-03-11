import '../../core/utils/result.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;
  GetProductsUseCase(this.repository);

  Future<Result<List<ProductEntity>>> call({
    required int limit,
    required int skip,
  }) {
    return repository.getProducts(limit: limit, skip: skip);
  }
}