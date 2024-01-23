import 'package:ecommerce_mobile_app/data/models/cart_item_model.dart';
import 'package:ecommerce_mobile_app/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/cart_cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';

class CartPage extends StatefulWidget {
  static const routeName = "cart";
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double total = 0;
  // fix it
  double cartTotal(List<CartItemModel> items) {
    for (int i = 0; i < items.length; i++) {
      //total = 0;
      print(" before $total");
      total += (items[i].product.price * items[i].quantity);
      print(" after $total");
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartCubitState>(
          builder: (context, state) {
            if (state is CartLodingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CartErrorState) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is CartLoadedState && state.cartItems.isEmpty) {
              return const Center(
                child: Text('Cart item will show here'),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = state.cartItems[index];
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${state.cartItems.length} item"),
                            Text("total: ${cartTotal(state.cartItems)}"),
                          ],
                        ),
                      ),
                      FilledButton(
                        onPressed: () {},
                        child: const Text("Place order"),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
