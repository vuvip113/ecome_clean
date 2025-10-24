import 'package:ecome_clean/common/helper/product/product_price.dart';
import 'package:ecome_clean/common/widgets/button/basic_reactive_button.dart';
import 'package:ecome_clean/domain/order/entities/order_entity.dart';
import 'package:ecome_clean/domain/order/usecase/add_to_cart.dart';
import 'package:ecome_clean/domain/product/entities/product_entity.dart';
import 'package:ecome_clean/presentation/product_detail/bloc/product_color_selection_cubit.dart';
import 'package:ecome_clean/presentation/product_detail/bloc/product_quantity_cubit.dart';
import 'package:ecome_clean/presentation/product_detail/bloc/product_size_selection_cubit.dart';
import 'package:ecome_clean/services/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToBag extends StatelessWidget {
  final ProductEntity productEntity;
  const AddToBag({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: BasicReactiveButton(
        onPressed: () async {
          final addToCart = sl<AddToCart>();
          final quantity = context.read<ProductQuantityCubit>().state;

          final order = OrderEntity(
            productId: productEntity.productId,
            productTitle: productEntity.title,
            productQuantity: quantity,
            productColor: productEntity
                .colors[context.read<ProductColorSelectionCubit>().slectedIndex]
                .title,
            productSize: productEntity
                .sizes[context.read<ProductSizeSelectionCubit>().selectedIndex],
            productPrice: ProductPriceHelper.provideCurrencyPrice(
              productEntity,
            ),
            totalPrice:
                ProductPriceHelper.provideCurrencyPrice(productEntity) *
                quantity,
            productImage: productEntity.images[0],
            createdDate: DateTime.now(),
          );
          final result = await addToCart(order);
          result.fold(
            (failure) => ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('❌ ${failure.message}'))),
            (_) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('✅ Added to cart successfully!')),
            ),
          );
        },
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<ProductQuantityCubit, int>(
              builder: (context, state) {
                final price =
                    ProductPriceHelper.provideCurrencyPrice(productEntity) *
                    state;
                return Text(
                  "\$${price.toString()}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                );
              },
            ),
            const Text(
              'Add to Bag',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
