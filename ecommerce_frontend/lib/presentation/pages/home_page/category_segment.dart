import 'package:ecommerce_mobile_app/logic/cubit/category_cubit/category_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/category_cubit/category_state.dart';
import 'package:ecommerce_mobile_app/presentation/pages/product_page/category_product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorySegment extends StatefulWidget {
  const CategorySegment({super.key});

  @override
  State<CategorySegment> createState() => _CategorySegmentState();
}

class _CategorySegmentState extends State<CategorySegment> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLodingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CategoryErrorState) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state.categories.isEmpty) {
          return const Center(
            child: Text('No Category'),
          );
        }
        return ListView.builder(
          itemCount: state.categories.length,
          itemBuilder: (context, index) {
            var category = state.categories[index];
            return ListTile(
              onTap: () {
                Navigator.of(context).pushNamed(
                  CategoryProductPage.routeName,
                  arguments: category,
                );
              },
              leading: const Icon(Icons.category),
              title: Text(category.title ?? "No Title"),
              trailing: const Icon(Icons.keyboard_arrow_right),
            );
          },
        );
      },
    );
  }
}
