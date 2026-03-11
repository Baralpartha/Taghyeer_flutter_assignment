import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final double price;
  final String thumbnail;
  final String description;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.description,
  });

  @override
  List<Object?> get props => [id, title, price, thumbnail, description];
}