import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecome_clean/core/errors/exception.dart';
import 'package:ecome_clean/data/category/models/category_model.dart';

abstract class CategoryDataSource {
  Future<List<CategoryModel>> getCategories();
}

class CategoryDataSourceImpl implements CategoryDataSource {
  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final categories = await FirebaseFirestore.instance
          .collection('Categories')
          .get();
      final data = categories.docs.map((doc) {
        final data = doc.data();
        return CategoryModel.fromJson({
          'id': doc.id,
          ...data, // gộp toàn bộ field trong document
        });
      }).toList();
      return data;
    } catch (e) {
      throw ServerException(
        massage: 'Failed to load categories: $e',
        statusCode: 400,
      );
    }
  }
}
