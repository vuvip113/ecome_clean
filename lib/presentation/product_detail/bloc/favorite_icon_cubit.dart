import 'package:ecome_clean/domain/product/entities/product_entity.dart';
import 'package:ecome_clean/domain/product/usecases/add_or_remove_favorite_product.dart';
import 'package:ecome_clean/domain/product/usecases/is_favorite.dart';
import 'package:ecome_clean/services/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteIconCubit extends Cubit<bool> {
  FavoriteIconCubit() : super(false);

  void isFavorite(String productId) async {
    var result = await sl<IsFavoriteUseCase>().call(productId);
    result.fold((failure) => emit(false), (isFav) => emit(isFav));
  }

  void onTap(ProductEntity product) async {
    var result = await sl<AddOrRemoveFavoriteProductUseCase>().call(product);
    result.fold(
      (failure) {
        // Có thể thêm log lỗi hoặc snackbar ở đây
        print(failure.message);
      },
      (data) async {
        isFavorite(product.productId);
      },
    );
  }
}
