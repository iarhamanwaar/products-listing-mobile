import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.description,
  });

  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String? description;

  @override
  List<Object?> get props => [id, name, price, imageUrl, description];
}
