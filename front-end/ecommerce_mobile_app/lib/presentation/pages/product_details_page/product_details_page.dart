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
  const ProductDetailsPage({super.key, required this.productModel});

  final ProductModel productModel;
  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productModel.title ?? "No title"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width,
              child: CarouselSlider.builder(
                  itemCount: widget.productModel.images?.length ?? 3,
                  itemBuilder: (context, index, realIdx) {
                    return Container(
                      child: Text(index.toString()),
                    );
                  },
                  options: CarouselOptions()),
            ),
            const Gap(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                //mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.productModel.title ?? " Title"),
                  Text(
                    widget.productModel.price.toString(),
                    style: TextStyles.heading3,
                  ),
                  const Gap(),
                  BlocBuilder<CartCubit, CartCubitState>(
                      builder: (context, state) {
                    return FilledButton(
                      onPressed: () {
                        if (BlocProvider.of<CartCubit>(context)
                            .cartContains(widget.productModel)) {
                          return;
                        }
                        BlocProvider.of<CartCubit>(context)
                            .addToCart(widget.productModel, 1);
                      },
                      child: (BlocProvider.of<CartCubit>(context)
                              .cartContains(widget.productModel))
                          ? const Text("Product Added to cart")
                          : const Text("Add to cart"),
                    );
                  }),
                  const Gap(),
                  Text(widget.productModel.description ?? " no description"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
