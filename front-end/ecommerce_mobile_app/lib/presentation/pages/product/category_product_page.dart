import 'package:ecommerce_mobile_app/data/models/category_model.dart';
import 'package:ecommerce_mobile_app/logic/cubit/category_product_cubit/category_product_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/category_product_cubit/category_product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductPage extends StatefulWidget {
  static const routeName = "Category-Product-Page";
  const CategoryProductPage({super.key, required this.category});
  final CategoryModel category;

  @override
  State<CategoryProductPage> createState() => _CategoryProductPageState();
}

class _CategoryProductPageState extends State<CategoryProductPage> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CategoryProductCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: SafeArea(
          child: BlocBuilder<CategoryProductCubit, CategoryProductState>(
        builder: (context, state) {
          if (state is CategoryProductLodingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CategoryProductErrorState) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state.products.isEmpty) {
            return const Center(
              child: Text('No product'),
            );
          }
          return Center();
        },
      )),
    );
  }
}
