// products_state.dart
import '../../../domain/entities/product_entity.dart';

class ProductsState {
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;
  final List<ProductEntity> items;

  const ProductsState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.error,
    this.items = const [],
  });

  ProductsState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
    List<ProductEntity>? items,
  }) {
    return ProductsState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      error: error,
      items: items ?? this.items,
    );
  }
}