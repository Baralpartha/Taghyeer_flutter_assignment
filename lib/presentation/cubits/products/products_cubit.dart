// products_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/api_constants.dart';
import '../../../domain/usecases/get_products_usecase.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final GetProductsUseCase getProductsUseCase;
  ProductsCubit(this.getProductsUseCase) : super(const ProductsState());

  int _skip = 0;
  bool _busy = false;

  Future<void> fetchInitial() async {
    _skip = 0;
    emit(const ProductsState(isLoading: true));

    final result = await getProductsUseCase(limit: ApiConstants.pageSize, skip: _skip);

    if (result.isSuccess) {
      final items = result.data ?? [];
      emit(
        ProductsState(
          isLoading: false,
          items: items,
          hasMore: items.length == ApiConstants.pageSize,
        ),
      );
      _skip = items.length;
    } else {
      emit(ProductsState(isLoading: false, error: result.error));
    }
  }

  Future<void> fetchMore() async {
    if (_busy || !state.hasMore || state.isLoading) return;
    _busy = true;

    emit(state.copyWith(isLoadingMore: true, error: null));

    final result = await getProductsUseCase(limit: ApiConstants.pageSize, skip: _skip);

    if (result.isSuccess) {
      final newItems = result.data ?? [];
      emit(
        state.copyWith(
          isLoadingMore: false,
          items: [...state.items, ...newItems],
          hasMore: newItems.length == ApiConstants.pageSize,
        ),
      );
      _skip += newItems.length;
    } else {
      emit(state.copyWith(isLoadingMore: false, error: result.error));
    }

    _busy = false;
  }
}