import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecome_clean/core/errors/exception.dart';
import 'package:ecome_clean/data/product/models/product_model.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> getTopSelling();
}

class ProductDataSourceImpl implements ProductDataSource {
  @override
  Future<List<ProductModel>> getTopSelling() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Products')
          .where('salesNumber', isGreaterThanOrEqualTo: 20)
          .orderBy('salesNumber', descending: true)
          .get();

      final products = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return ProductModel.fromMap(data);
      }).toList();

      return products;
    } catch (e) {
      throw ServerException(
        massage: 'Failed to load getTopSelling: $e',
        statusCode: 400,
      );
    }
  }
}
