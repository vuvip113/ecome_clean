import 'dart:async';

import 'package:ecome_clean/common/bloc/product/products_display_cubit.dart';
import 'package:ecome_clean/core/configs/assets/app_vectors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchField extends StatelessWidget {
  SearchField({super.key});

  final TextEditingController textEditingController = TextEditingController();

  // 🔸 Biến tĩnh để debounce (giữ timer giữa các lần gõ)
  static Timer? _debounce;

  void _onSearchChanged(BuildContext context, String value) {
    // Hủy timer cũ nếu người dùng tiếp tục gõ
    _debounce?.cancel();

    // Tạo timer mới 2 giây
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (value.isEmpty) {
        context.read<ProductsDisplayCubit>().displayInitial();
      } else {
        context.read<ProductsDisplayCubit>().displayProducts(params: value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: textEditingController,
        onChanged: (value) {
          _onSearchChanged(context, value);
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(12),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          prefixIcon: SvgPicture.asset(AppVectors.search, fit: BoxFit.none),
          hintText: 'search',
        ),
      ),
    );
  }
}
