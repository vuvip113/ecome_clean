import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecome_clean/core/errors/exception.dart';
import 'package:ecome_clean/data/order/models/order_model.dart';
import 'package:ecome_clean/data/order/models/order_status_model.dart';
import 'package:ecome_clean/data/order/models/product_order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class OrderDataSource {
  Future<void> addToCart(ProductOrderModel order);
  Future<List<ProductOrderModel>> getCartProducts();
  Future<void> orderRegistration(OrderModel order);
  Future<void> removeFromCart(String orderId);
  Future<List<OrderModel>> getOrders();
}

class OrderDataSourceImpl implements OrderDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  OrderDataSourceImpl({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  @override
  Future<void> addToCart(ProductOrderModel order) async {
    try {
      final user = _auth.currentUser;
      final docRef = _firestore
          .collection('Users')
          .doc(user!.uid)
          .collection('Cart')
          .doc();

      final orderWithId = order.copyWith(cartItemId: docRef.id);
      await docRef.set(orderWithId.toMap());
    } catch (e) {
      throw ServerException(
        massage: 'Failed to add to cart: $e',
        statusCode: 400,
      );
    }
  }

  @override
  Future<List<ProductOrderModel>> getCartProducts() async {
    try {
      final user = _auth.currentUser;
      final cartSnapshot = await _firestore
          .collection('Users')
          .doc(user!.uid)
          .collection('Cart')
          .get();

      final List<ProductOrderModel> orders = cartSnapshot.docs.map((doc) {
        return ProductOrderModel.fromJson(doc.data(), cartItemId: doc.id);
      }).toList();

      return orders;
    } catch (e) {
      throw ServerException(
        massage: 'Failed to get cart products: $e',
        statusCode: 404,
      );
    }
  }

  @override
  Future<void> removeFromCart(String orderId) async {
    try {
      final user = _auth.currentUser;
      final docRef = _firestore
          .collection('Users')
          .doc(user!.uid)
          .collection('Cart')
          .doc(orderId);

      await docRef.delete();
    } catch (e) {
      throw ServerException(
        massage: 'Failed to remove from cart: $e',
        statusCode: 400,
      );
    }
  }

  @override
  Future<void> orderRegistration(OrderModel order) async {
    try {
      final user = _auth.currentUser;
      final docRef = _firestore
          .collection('Users')
          .doc(user!.uid)
          .collection('Orders')
          .doc();

      final now = DateTime.now();
      final randomCode = (100000 + (now.millisecondsSinceEpoch % 900000))
          .toString();
      final uniqueCode = '${user.uid}_$randomCode';

      final List<OrderStatusModel> orderStatus = [
        OrderStatusModel(title: 'Order Placed', createdDate: now, done: true),
        OrderStatusModel(
          title: 'Order Confirmed',
          createdDate: now.add(const Duration(days: 1)),
          done: false,
        ),
        OrderStatusModel(
          title: 'Shipped',
          createdDate: now.add(const Duration(days: 2)),
          done: false,
        ),
        OrderStatusModel(
          title: 'Delivered',
          createdDate: now.add(const Duration(days: 3)),
          done: false,
        ),
      ];

      final orderWithExtras = order.copyWith(
        orderId: docRef.id,
        code: uniqueCode,
        createdDate: now,
        orderStatus: orderStatus,
      );

      await docRef.set(orderWithExtras.toJson());

      for (var product in order.products) {
        final cartDocRef = _firestore
            .collection('Users')
            .doc(user.uid)
            .collection('Cart')
            .doc(product.cartItemId);
        await cartDocRef.delete();
      }
    } catch (e) {
      throw ServerException(
        massage: 'Failed to remove from cart: $e',
        statusCode: 400,
      );
    }
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    try {
      final user = _auth.currentUser;
      final docRef = await _firestore
          .collection('Users')
          .doc(user!.uid)
          .collection('Orders')
          .orderBy('createdDate', descending: true)
          .get();

      final List<OrderModel> orders = docRef.docs.map((doc) {
        return OrderModel.fromMap(doc.data());
      }).toList();

      return orders;
    } catch (e) {
      throw ServerException(
        massage: 'Failed to get Orders: $e',
        statusCode: 400,
      );
    }
  }
}
