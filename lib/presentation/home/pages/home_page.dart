import 'package:ecome_clean/presentation/home/widgets/categories.dart';
import 'package:ecome_clean/presentation/home/widgets/header.dart';
import 'package:ecome_clean/presentation/home/widgets/new_in.dart';
import 'package:ecome_clean/presentation/home/widgets/search_field.dart';
import 'package:ecome_clean/presentation/home/widgets/top_selling.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(),
            SizedBox(height: 24),
            SearchField(),
            SizedBox(height: 24),
            Categories(),
            SizedBox(height: 24),
            TopSelling(),
            SizedBox(height: 24),
            NewIn(),
          ],
        ),
      ),
    );
  }
}
