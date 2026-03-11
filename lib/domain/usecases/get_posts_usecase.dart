import '../../core/utils/result.dart';
import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

class GetPostsUseCase {
  final PostRepository repository;
  GetPostsUseCase(this.repository);

  Future<Result<List<PostEntity>>> call({
    required int limit,
    required int skip,
  }) {
    return repository.getPosts(limit: limit, skip: skip);
  }
}