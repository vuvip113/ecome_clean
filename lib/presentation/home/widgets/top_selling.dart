import 'package:ecome_clean/common/widgets/product/product_card.dart';
import 'package:ecome_clean/domain/product/entities/product_entity.dart';
import 'package:ecome_clean/presentation/home/bloc/cubit/top_selling_display_cubit.dart';
import 'package:ecome_clean/services/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopSelling extends StatelessWidget {
  const TopSelling({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopSellingDisplayCubit(sl())..displayTopSelling(),
      child: BlocBuilder<TopSellingDisplayCubit, TopSellingDisplayState>(
        builder: (context, state) {
          if (state is TopSellingDisplayLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TopSellingDisplayLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _topSelling(),
                const SizedBox(height: 20),
                _products(state.products),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _topSelling() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        'Top Selling',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _products(List<ProductEntity> products) {
    return SizedBox(
      height: 300,
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ProductCard(productEntity: products[index]);
        },
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: products.length,
      ),
    );
  }
}
