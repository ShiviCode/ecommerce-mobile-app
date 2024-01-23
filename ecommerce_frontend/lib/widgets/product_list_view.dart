import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_mobile_app/core/ui.dart';
import 'package:ecommerce_mobile_app/data/models/product_model.dart';
import 'package:ecommerce_mobile_app/presentation/pages/product_details_page/product_details_page.dart';
import 'package:flutter/material.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({super.key, required this.products});
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: products.length,
      itemBuilder: (context, index) {
        var product = products[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(ProductDetailsPage.routeName, arguments: product);
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
  }
}
