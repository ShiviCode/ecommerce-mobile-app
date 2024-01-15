import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_mobile_app/core/ui.dart';
import 'package:ecommerce_mobile_app/logic/cubit/product_cubit/product_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/product_cubit/product_state.dart';
import 'package:ecommerce_mobile_app/presentation/pages/product_details_page/product_details_page.dart';
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
        return ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: state.products.length,
          itemBuilder: (context, index) {
            var product = state.products[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ProductDetailsPage.routeName,
                      arguments: product);
                },
                child: Row(
                  children: [
                    CachedNetworkImage(
                      width: MediaQuery.of(context).size.width / 3,
                      imageUrl: product.images[0],
                      fit: BoxFit.contain,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              style: TextStyles.heading4
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              product.description,
                              style: TextStyles.body2.copyWith(
                                color: AppColors.textLight,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            //  Gap(),
                            Text(
                              "₹ ${product.price}",
                              style: TextStyles.heading3,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: const Icon(Icons.shopping_cart_outlined),
                    // ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
