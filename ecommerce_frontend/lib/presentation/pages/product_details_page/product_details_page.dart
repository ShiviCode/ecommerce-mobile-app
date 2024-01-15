import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_mobile_app/core/ui.dart';
import 'package:ecommerce_mobile_app/data/models/product_model.dart';
import 'package:ecommerce_mobile_app/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/cart_cubit/cart_state.dart';
import 'package:ecommerce_mobile_app/widgets/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatefulWidget {
  static const routeName = "product-details";
  const ProductDetailsPage({super.key, required this.product});

  final ProductModel product;
  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width,
              child: CarouselSlider.builder(
                itemCount: widget.product.images.length,
                itemBuilder: (context, index, realIdx) {
                  return CachedNetworkImage(
                    imageUrl: widget.product.images[index],
                    // fit: BoxFit.contain,
                  );
                },
                options: CarouselOptions(),
              ),
            ),
            const Gap(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.product.title,
                    style: TextStyles.heading2,
                  ),
                  Text(
                    "₹ ${widget.product.price}",
                    style: TextStyles.heading3,
                  ),
                  const Gap(),
                  BlocBuilder<CartCubit, CartCubitState>(
                      builder: (context, state) {
                    return FilledButton(
                      style: FilledButton.styleFrom(
                          backgroundColor:
                              // (BlocProvider.of<CartCubit>(context)
                              //         .cartContains(widget.product))
                              //     ? AppColors.textLight
                              //     :
                              AppColors.accent,
                          maximumSize: MediaQuery.of(context).size),
                      onPressed: (BlocProvider.of<CartCubit>(context)
                              .cartContains(widget.product))
                          ? null
                          : () {
                              BlocProvider.of<CartCubit>(context)
                                  .addToCart(widget.product, 1);
                            },
                      // () {
                      //   if (BlocProvider.of<CartCubit>(context)
                      //       .cartContains(widget.product)) {
                      //     return;
                      //   }
                      //   BlocProvider.of<CartCubit>(context)
                      //       .addToCart(widget.product, 1);
                      // },
                      child: (BlocProvider.of<CartCubit>(context)
                              .cartContains(widget.product))
                          ? const Text("Product Added to cart...")
                          : const Text("Add to cart"),
                    );
                  }),
                  const Gap(),
                  Text(
                    widget.product.description,
                    style: TextStyles.body1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
