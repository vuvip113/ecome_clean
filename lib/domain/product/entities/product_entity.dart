import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String productId;
  final String title;
  final String categoryId;
  final List<ProductColor> colors;
  final DateTime createdDate;
  final int gender; // 1 = Nam, 2 = Nữ, 3 = Unisex,...
  final List<String> images;
  final double price; // Giá gốc
  final double discountedPrice; // Giá đã giảm
  final int salesNumber;
  final List<String> sizes;

  const ProductEntity({
    required this.productId,
    required this.title,
    required this.categoryId,
    required this.colors,
    required this.createdDate,
    required this.gender,
    required this.images,
    required this.price,
    required this.discountedPrice,
    required this.salesNumber,
    required this.sizes,
  });

  @override
  List<Object?> get props => [
    productId,
    title,
    categoryId,
    colors,
    createdDate,
    gender,
    images,
    price,
    discountedPrice,
    salesNumber,
    sizes,
  ];
}

class ProductColor extends Equatable {
  final String title;
  final List<int> rgb;

  const ProductColor({required this.rgb, required this.title});

  @override
  List<Object?> get props => [rgb, title];
}
