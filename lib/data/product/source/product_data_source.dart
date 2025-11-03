import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecome_clean/core/errors/exception.dart';
import 'package:ecome_clean/data/product/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> getTopSelling();
  Future<List<ProductModel>> getNewIn();
  Future<List<ProductModel>> getProductsByCategoryId(String categoryId);
  Future<List<ProductModel>> getProductsByTitle(String title);
  Future<List<ProductModel>> addOrRemoveFavProduct(ProductModel product);
  Future<bool> isFav(String productId);
  Future<List<ProductModel>> getFavoriteProducts();
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

  @override
  Future<List<ProductModel>> getNewIn() async {
    try {
      final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Products')
          .where('createdDate', isGreaterThanOrEqualTo: sevenDaysAgo)
          .orderBy('createdDate', descending: true)
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

  @override
  Future<List<ProductModel>> getProductsByCategoryId(String categoryId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Products')
          .where('categoryId', isEqualTo: categoryId)
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

  @override
  Future<List<ProductModel>> getProductsByTitle(String title) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Products')
          .where('title', isGreaterThanOrEqualTo: title)
          .get();

      final products = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return ProductModel.fromMap(data);
      }).toList();

      return products;
    } catch (e) {
      throw ServerException(
        massage: 'Failed to load getProductsByTitle: $e',
        statusCode: 400,
      );
    }
  }

  @override
  Future<List<ProductModel>> addOrRemoveFavProduct(ProductModel product) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final favCollection = FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('FavProducts');

      final existing = await favCollection
          .where('productId', isEqualTo: product.productId)
          .get();

      if (existing.docs.isNotEmpty) {
        await favCollection.doc(existing.docs.first.id).delete();
      } else {
        await favCollection.add(product.toMap());
      }

      final favSnapshot = await favCollection.get();
      return favSnapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw ServerException(
        massage: 'Failed to load getProductsByTitle: $e',
        statusCode: 400,
      );
    }
  }

  @override
  Future<bool> isFav(String productId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final favCollection = FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('FavProducts');
      final existing = await favCollection
          .where('productId', isEqualTo: productId)
          .limit(1)
          .get();
      return existing.docs.isNotEmpty;
    } catch (e) {
      throw ServerException(
        massage: 'Failed to load getProductsByTitle: $e',
        statusCode: 400,
      );
    }
  }

  @override
  Future<List<ProductModel>> getFavoriteProducts() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      final snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('FavProducts')
          .get();

      return snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw ServerException(
        massage: 'Failed to load favorite products: $e',
        statusCode: 400,
      );
    }
  }
}
