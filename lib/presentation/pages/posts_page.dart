import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubits/posts/posts_cubit.dart';
import '../cubits/posts/posts_state.dart';
import '../widgets/app_empty_view.dart';
import '../widgets/app_error_view.dart';
import '../widgets/app_loader.dart';
import '../widgets/pagination_loader.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (controller.position.pixels >= controller.position.maxScrollExtent - 200) {
      context.read<PostsCubit>().fetchMore();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String preview(String text) {
    if (text.length <= 80) return text;
    return '${text.substring(0, 80)}...';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts')),
      body: BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) {
          if (state.isLoading) return const AppLoader();

          if (state.error != null && state.items.isEmpty) {
            return AppErrorView(
              message: state.error!,
              onRetry: () => context.read<PostsCubit>().fetchInitial(),
            );
          }

          if (state.items.isEmpty) {
            return const AppEmptyView(message: 'No posts found.');
          }

          return RefreshIndicator(
            onRefresh: () => context.read<PostsCubit>().fetchInitial(),
            child: ListView.builder(
              controller: controller,
              itemCount: state.items.length + (state.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == state.items.length) {
                  return const PaginationLoader();
                }

                final item = state.items[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(item.title),
                    subtitle: Text(preview(item.body)),
                    onTap: () => context.push('/post-detail', extra: item),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}