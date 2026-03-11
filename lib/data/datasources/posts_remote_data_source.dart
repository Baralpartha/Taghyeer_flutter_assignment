import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';
import '../models/post_model.dart';

class PostsRemoteDataSource {
  final DioClient client;
  PostsRemoteDataSource(this.client);

  Future<List<PostModel>> getPosts({
    required int limit,
    required int skip,
  }) async {
    final response = await client.get(
      ApiConstants.posts,
      queryParameters: {'limit': limit, 'skip': skip},
    );

    final List posts = response.data['posts'] ?? [];
    return posts.map((e) => PostModel.fromJson(e)).toList();
  }
}