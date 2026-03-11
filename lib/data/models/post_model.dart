// post_model.dart
import '../../domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  const PostModel({
    required super.id,
    required super.title,
    required super.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }
}