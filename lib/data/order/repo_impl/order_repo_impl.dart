import 'package:dartz/dartz.dart';
import 'package:ecome_clean/core/errors/exception.dart';
import 'package:ecome_clean/core/errors/failures.dart';
import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/data/order/models/order_model.dart';
import 'package:ecome_clean/data/order/models/product_order_model.dart';
import 'package:ecome_clean/data/order/source/order_data_source.dart';
import 'package:ecome_clean/domain/order/entities/order_entity.dart';
import 'package:ecome_clean/domain/order/entities/product_order_entity.dart';
import 'package:ecome_clean/domain/order/repo/order_repo.dart';

class OrderRepoImpl implements OrderRepo {
  final OrderDataSource _orderDataSource;

  OrderRepoImpl({required OrderDataSource orderDataSource})
    : _orderDataSource = orderDataSource;
  @override
  ResultFuture<void> addToCart(ProductOrderEntity  order) async {
    try {
      final orderModel = ProductOrderModel.fromEntity(order);

      await _orderDataSource.addToCart(orderModel);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.massage, statusCode: e.statusCode));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Unexpected error: $e', statusCode: 500),
      );
    }
  }

  @override
  ResultFuture<List<ProductOrderEntity>> getCartProducts() async {
    try {
      final models = await _orderDataSource.getCartProducts();
      final entities = models.map((m) => m.toEntity()).toList();
      return Right(entities);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.massage, statusCode: e.statusCode));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Unexpected error: $e', statusCode: 500),
      );
    }
  }

  @override
  ResultFuture<void> removeFromCart(String orderId) async {
    try {
      await _orderDataSource.removeFromCart(orderId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.massage, statusCode: e.statusCode));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Unexpected error: $e', statusCode: 500),
      );
    }
  }

  @override
  ResultFuture<void> orderRegistration(OrderEntity  order) async {
    try {
     final model = OrderModel.fromEntity(order);
      await _orderDataSource.orderRegistration(model);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.massage, statusCode: e.statusCode));
    } catch (e) {
      return Left(
        ServerFailure(message: 'Unexpected error: $e', statusCode: 500),
      );
    }
  }
}
