import 'package:ecome_clean/common/widgets/appbar/app_bar.dart';
import 'package:ecome_clean/domain/order/entities/product_order_entity.dart';
import 'package:ecome_clean/presentation/settings/widgets/product_ordered_card.dart';
import 'package:flutter/material.dart';

class OrderItemsPage extends StatelessWidget {
  final List<ProductOrderEntity> products;
  const OrderItemsPage({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(title: Text('Order Items')),
      body: _products(),
    );
  }

  Widget _products() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return OrderItemCard(productOrderedEntity: products[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: products.length,
    );
  }
}
