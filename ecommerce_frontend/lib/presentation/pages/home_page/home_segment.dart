import 'package:ecommerce_mobile_app/logic/cubit/product_cubit/product_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/product_cubit/product_state.dart';
import 'package:ecommerce_mobile_app/widgets/product_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeSegment extends StatefulWidget {
  const HomeSegment({super.key});

  @override
  State<HomeSegment> createState() => _HomeSegmentState();
}

class _HomeSegmentState extends State<HomeSegment> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLodingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProductErrorState) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state.products.isEmpty) {
          return const Center(
            child: Text('No Product'),
          );
        }
        return ProductListView(products: state.products);
      },
    );
  }
}
