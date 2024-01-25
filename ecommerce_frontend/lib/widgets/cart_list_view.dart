import 'package:ecommerce_mobile_app/data/models/cart_item_model.dart';
import 'package:ecommerce_mobile_app/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';

class CartListView extends StatelessWidget {
  final List<CartItemModel> cartItems;
  final bool shrinkWrap;
  final bool noScroll;
  const CartListView({
    super.key,
    required this.cartItems,
    this.shrinkWrap = false,
    this.noScroll = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      physics: noScroll ? const NeverScrollableScrollPhysics() : null,
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];
        return ListTile(
          title: Text(item.product.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '${item.product.price} x ${item.quantity} = ${item.product.price * item.quantity}'),
              IconButton(
                  onPressed: () {
                    BlocProvider.of<CartCubit>(context)
                        .removeFromCart(item.product);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))
            ],
          ),
          trailing: InputQty(
            minVal: 1,
            initVal: item.quantity, // product initial value
            //showMessageLimit: false,
            onQtyChanged: (value) {
              BlocProvider.of<CartCubit>(context)
                  .addToCart(item.product, value.toInt());
            },
          ),
        );
      },
    );
  }
}
