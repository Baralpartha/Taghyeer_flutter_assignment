import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubits/products/products_cubit.dart';
import '../cubits/products/products_state.dart';
import '../widgets/app_empty_view.dart';
import '../widgets/app_error_view.dart';
import '../widgets/app_loader.dart';
import '../widgets/pagination_loader.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (controller.position.pixels >= controller.position.maxScrollExtent - 200) {
      context.read<ProductsCubit>().fetchMore();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state.isLoading) return const AppLoader();

          if (state.error != null && state.items.isEmpty) {
            return AppErrorView(
              message: state.error!,
              onRetry: () => context.read<ProductsCubit>().fetchInitial(),
            );
          }

          if (state.items.isEmpty) {
            return const AppEmptyView(message: 'No products found.');
          }

          return RefreshIndicator(
            onRefresh: () => context.read<ProductsCubit>().fetchInitial(),
            child: ListView.builder(
              controller: controller,
              itemCount: state.items.length + (state.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == state.items.length) {
                  return const PaginationLoader();
                }

                final item = state.items[index];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.thumbnail,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                    ),
                  ),
                  title: Text(item.title),
                  subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                  onTap: () => context.push('/product-detail', extra: item),
                );
              },
            ),
          );
        },
      ),
    );
  }
}