import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecome_clean/core/errors/exception.dart';
import 'package:ecome_clean/data/order/models/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class OrderDataSource {
  Future<void> addToCart(OrderModel order);
  Future<List<OrderModel>> getCartProducts();
}

class OrderDataSourceImpl implements OrderDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  OrderDataSourceImpl({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  @override
  Future<void> addToCart(OrderModel order) async {
    try {
      final user = _auth.currentUser;
      final docRef = _firestore
          .collection('Users')
          .doc(user!.uid)
          .collection('Cart')
          .doc();

      final orderWithId = order.copyWith(cartItemId: docRef.id);
      await docRef.set(orderWithId.toJson());
    } catch (e) {
      throw ServerException(
        massage: 'Failed to add to cart: $e',
        statusCode: 400,
      );
    }
  }

  @override
  Future<List<OrderModel>> getCartProducts() async {
    try {
      final user = _auth.currentUser;
      final cartSnapshot = await _firestore
          .collection('Users')
          .doc(user!.uid)
          .collection('Cart')
          .get();

      final List<OrderModel> orders = cartSnapshot.docs.map((doc) {
        return OrderModel.fromJson(doc.data(), cartItemId: doc.id);
      }).toList();

      return orders;
    } catch (e) {
      throw ServerException(
        massage: 'Failed to get cart products: $e',
        statusCode: 404,
      );
    }
  }
}
