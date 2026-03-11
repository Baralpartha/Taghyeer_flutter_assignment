// posts_state.dart
import '../../../domain/entities/post_entity.dart';

class PostsState {
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;
  final List<PostEntity> items;

  const PostsState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.error,
    this.items = const [],
  });

  PostsState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
    List<PostEntity>? items,
  }) {
    return PostsState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      error: error,
      items: items ?? this.items,
    );
  }
}