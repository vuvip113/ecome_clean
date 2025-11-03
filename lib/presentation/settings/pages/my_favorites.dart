import 'package:ecome_clean/common/bloc/product/products_display_cubit.dart';
import 'package:ecome_clean/common/widgets/appbar/app_bar.dart';
import 'package:ecome_clean/common/widgets/product/product_card.dart';
import 'package:ecome_clean/core/configs/assets/app_images.dart';
import 'package:ecome_clean/domain/product/entities/product_entity.dart';
import 'package:ecome_clean/domain/product/usecases/get_favorties_products.dart';
import 'package:ecome_clean/services/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyFavoritesPage extends StatelessWidget {
  const MyFavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(title: Text('My Favorites')),
      body: BlocProvider(
        create: (context) =>
            ProductsDisplayCubit(sl<GetFavortiesProductsUseCase>())
              ..displayProducts(),
        child: BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
          builder: (context, state) {
            if (state is ProductsDisplayLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProductsDisplayLoaded) {
              return state.products.isEmpty
                  ? _notFound()
                  : _products(state.products);
            }

            if (state is ProductsDisplayError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _products(List<ProductEntity> products) {
    return Expanded(
      child: GridView.builder(
        itemCount: products.length,
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.6,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(productEntity: products[index]);
        },
      ),
    );
  }

  Widget _notFound() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Image.asset(AppImages.orderPlaced),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            'No Favorites yet',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ],
    );
  }
}
