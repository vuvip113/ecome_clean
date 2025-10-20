import 'package:dartz/dartz.dart';
import 'package:ecome_clean/core/errors/exception.dart';
import 'package:ecome_clean/core/errors/failures.dart';
import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/data/product/source/product_data_source.dart';
import 'package:ecome_clean/domain/product/entities/product_entity.dart';
import 'package:ecome_clean/domain/product/repo/product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  final ProductDataSource dataSource;

  ProductRepoImpl(this.dataSource);

  @override
  ResultFuture<List<ProductEntity>> getTopSelling() async {
    try {
      final products = await dataSource.getTopSelling();
      return Right(products);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.massage, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<ProductEntity>> getNewIn() async {
    try {
      final products = await dataSource.getNewIn();
      return Right(products);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.massage, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<ProductEntity>> getProductsByCategoryId(
    String categoryId,
  ) async {
    try {
      final products = await dataSource.getProductsByCategoryId(categoryId);
      return Right(products);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.massage, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<ProductEntity>> getProductsByTitle(String title) async {
    try {
      final products = await dataSource.getProductsByTitle(title);
      return Right(products);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.massage, statusCode: e.statusCode));
    }
  }
}
