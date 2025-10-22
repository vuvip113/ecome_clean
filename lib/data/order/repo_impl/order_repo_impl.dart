import 'package:dartz/dartz.dart';
import 'package:ecome_clean/core/errors/exception.dart';
import 'package:ecome_clean/core/errors/failures.dart';
import 'package:ecome_clean/core/utils/constants/tydefs.dart';
import 'package:ecome_clean/data/order/models/order_model.dart';
import 'package:ecome_clean/data/order/source/order_data_source.dart';
import 'package:ecome_clean/domain/order/entities/order_entity.dart';
import 'package:ecome_clean/domain/order/repo/order_repo.dart';

class OrderRepoImpl implements OrderRepo {
  final OrderDataSource _orderDataSource;

  OrderRepoImpl({required OrderDataSource orderDataSource})
    : _orderDataSource = orderDataSource;
  @override
  ResultFuture<void> addToCart(OrderEntity order) async {
    try {
      final orderModel = OrderModel.fromEntity(order);

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
}
