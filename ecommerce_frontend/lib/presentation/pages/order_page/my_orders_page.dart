import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_mobile_app/core/ui.dart';
import 'package:ecommerce_mobile_app/data/models/order_model.dart';
import 'package:ecommerce_mobile_app/logic/cubit/order_cubit/order_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/order_cubit/order_state.dart';
import 'package:ecommerce_mobile_app/logic/cubit/user_cubit/user_state.dart';
import 'package:ecommerce_mobile_app/logic/services/formatter.dart';
import 'package:ecommerce_mobile_app/widgets/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersPage extends StatefulWidget {
  static const routeName = "/My-Orders-Page";
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            if (state is OrderLodingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is OrderErrorState) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is OrderLoadedState) {
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return Column(
                    children: [
                      const Gap(),
                      Divider(color: AppColors.accent),
                      const Gap(),
                    ],
                  );
                },
                padding: const EdgeInsets.all(16),
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  OrderModel order = state.orders[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "# - ${order.sId}",
                        style: TextStyles.body1
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Order Placed on: ${Formatter.formatDate(order.createdOn!)}",
                        style: TextStyles.body1
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      // Text(
                      //   "Order Total: ${Calcula}",
                      //   style: TextStyles.body1
                      //       .copyWith(fontWeight: FontWeight.bold),
                      // ),
                      const Gap(),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: order.items!.length,
                        itemBuilder: (context, index) {
                          final item = order.items![index];
                          final product = item.product;
                          return ListTile(
                            // leading: CachedNetworkImage(
                            //   width: MediaQuery.of(context).size.width / 3,
                            //   fit: BoxFit.contain,
                            //   imageUrl: product.images[0],
                            // ),
                            title: Text(product.title),
                            subtitle: Text("Qty: ${item.quantity}"),
                            trailing: Text("${product.price * item.quantity}"),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            }
            if (state is UserLoggedOutState) {
              return const Center(
                // add UI when user is logged out
                child: Text("User is logged out"),
              );
            }
            return const Center(
              child: Text("An error occured"),
            );
          },
        ),
      ),
    );
  }
}
