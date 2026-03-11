import '../../core/utils/result.dart';
import '../entities/post_entity.dart';

abstract class PostRepository {
  Future<Result<List<PostEntity>>> getPosts({
    required int limit,
    required int skip,
  });
}