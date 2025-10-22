import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecome_clean/core/errors/exception.dart';
import 'package:ecome_clean/data/order/models/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class OrderDataSource {
  Future<void> addToCart(OrderModel order);
}

class OrderDataSourceImpl implements OrderDataSource {
  @override
  Future<void> addToCart(OrderModel order) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('Cart')
          .add(order.toJson());

      
    } catch (e) {
      throw ServerException(
        massage: 'Failed to add to cart: $e',
        statusCode: 400,
      );
    }
  }
}
