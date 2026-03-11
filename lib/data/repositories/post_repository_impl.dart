// post_repository_impl.dart
import '../../core/utils/result.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/posts_remote_data_source.dart';

class PostRepositoryImpl implements PostRepository {
  final PostsRemoteDataSource remote;
  PostRepositoryImpl(this.remote);

  @override
  Future<Result<List<PostEntity>>> getPosts({
    required int limit,
    required int skip,
  }) async {
    try {
      final res = await remote.getPosts(limit: limit, skip: skip);
      return Result.success(res);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}