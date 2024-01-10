import 'package:ecommerce_mobile_app/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/cart_cubit/cart_state.dart';
import 'package:ecommerce_mobile_app/logic/cubit/category_cubit/category_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/category_cubit/category_state.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: SafeArea(
        child: BlocBuilder<CategoryCubit, CategoryState>(
      //  BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: const Text('p title'),
                        subtitle: const Text('p title'),
                        trailing: InputQty(
                          minVal: 1,
                          initVal: 2, // product initial value
                          //showMessageLimit: false,
                          onQtyChanged: (value) {},
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
                      const Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("5 item"),
                            Text("total: 857.5"),
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
