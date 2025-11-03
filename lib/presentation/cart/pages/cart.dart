import 'package:ecome_clean/common/widgets/appbar/app_bar.dart';
import 'package:ecome_clean/domain/order/entities/product_order_entity.dart';
import 'package:ecome_clean/presentation/cart/cubit/cart_products_display_cubit.dart';
import 'package:ecome_clean/presentation/cart/widgets/checkout.dart';
import 'package:ecome_clean/presentation/cart/widgets/product_ordered_card.dart';
import 'package:ecome_clean/services/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/configs/assets/app_vectors.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(title: Text('Cart')),
      body: BlocProvider(
        create: (context) => CartProductsDisplayCubit(sl())..loadCartProducts(),
        child: BlocBuilder<CartProductsDisplayCubit, CartProductsDisplayState>(
          builder: (context, state) {
            if (state is CartProductsDisplayLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CartProductsDisplayLoaded) {
              return state.products.isEmpty
                  ? Center(child: _cartIsEmpty())
                  : Stack(
                      children: [
                        _products(state.products),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Checkout(products: state.products),
                        ),
                      ],
                    );
            }
            if (state is CartProductsDisplayError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _products(List<ProductOrderEntity> products) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return ProductOrderedCard(productOrderedEntity: products[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: products.length,
    );
  }

  Widget _cartIsEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(AppVectors.cartBag),
        const SizedBox(height: 20),
        const Text(
          "Cart is empty",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ],
    );
  }
}
