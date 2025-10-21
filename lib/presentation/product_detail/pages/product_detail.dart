import 'package:ecome_clean/common/bloc/button/button_state_cubit.dart';
import 'package:ecome_clean/common/widgets/appbar/app_bar.dart';
import 'package:ecome_clean/domain/product/entities/product_entity.dart';
import 'package:ecome_clean/presentation/product_detail/bloc/product_color_selection_cubit.dart';
import 'package:ecome_clean/presentation/product_detail/bloc/product_quantity_cubit.dart';
import 'package:ecome_clean/presentation/product_detail/bloc/product_size_selection_cubit.dart';
import 'package:ecome_clean/presentation/product_detail/widgets/add_to_bag.dart';
import 'package:ecome_clean/presentation/product_detail/widgets/product_images.dart';
import 'package:ecome_clean/presentation/product_detail/widgets/product_price.dart';
import 'package:ecome_clean/presentation/product_detail/widgets/product_quantity.dart';
import 'package:ecome_clean/presentation/product_detail/widgets/product_title.dart';
import 'package:ecome_clean/presentation/product_detail/widgets/selected_color.dart';
import 'package:ecome_clean/presentation/product_detail/widgets/selected_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductDetailPage({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ButtonStateCubit()),
        BlocProvider(create: (_) => ProductQuantityCubit()),
        BlocProvider(create: (_) => ProductColorSelectionCubit()),
        BlocProvider(create: (_) => ProductSizeSelectionCubit()),
      ],
      child: Scaffold(
        appBar: const BasicAppbar(hideBack: false),
        bottomNavigationBar: AddToBag(productEntity: productEntity),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImages(productEntity: productEntity),
              const SizedBox(height: 10),
              ProductTitle(productEntity: productEntity),
              const SizedBox(height: 5),
              ProductPrice(productEntity: productEntity),
              const SizedBox(height: 10),
              SelectedSize(productEntity: productEntity),
              const SizedBox(height: 10),
              SelectedColor(productEntity: productEntity),
              const SizedBox(height: 10),
              ProductQuantity(productEntity: productEntity),
            ],
          ),
        ),
      ),
    );
  }
}
