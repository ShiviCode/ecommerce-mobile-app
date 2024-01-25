import 'package:ecommerce_mobile_app/core/ui.dart';
import 'package:ecommerce_mobile_app/data/models/user_model.dart';
import 'package:ecommerce_mobile_app/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/cart_cubit/cart_state.dart';
import 'package:ecommerce_mobile_app/logic/cubit/order_cubit/order_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/user_cubit/user_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/user_cubit/user_state.dart';
import 'package:ecommerce_mobile_app/presentation/pages/order_page/order_placed_page.dart';
import 'package:ecommerce_mobile_app/presentation/pages/user_page/edit_profile_page.dart';
import 'package:ecommerce_mobile_app/widgets/cart_list_view.dart';
import 'package:ecommerce_mobile_app/widgets/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailPage extends StatefulWidget {
  static const routeName = "/Order-Detail-Page";
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  String? paymentMode = "pay-now";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Order"),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // User
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserLodingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is UserErrorState) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                if (state is UserLoggedInState) {
                  UserModel user = state.userModel;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "User Details",
                        style: TextStyles.body1
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Gap(),
                      Text(user.fullName, style: TextStyles.heading4),
                      Text("Email: ${user.email}", style: TextStyles.body1),
                      Text("Phone: ${user.phoneNumber}",
                          style: TextStyles.body1),
                      Text(
                          "Address: ${user.address}, ${user.city}, ${user.state}",
                          style: TextStyles.body1),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(EditProfilePage.routeName);
                        },
                        child: const Text("Edit profile"),
                      ),
                    ],
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
            const Gap(size: 10),
            // cart
            Text(
              "Items",
              style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold),
            ),
            BlocBuilder<CartCubit, CartCubitState>(
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
                //if (state is CartLoadedState) {}
                return CartListView(
                  shrinkWrap: true,
                  noScroll: true,
                  cartItems: state.cartItems,
                );
              },
            ),
            const Gap(size: 10),
            // Payment
            Text(
              "Payment",
              style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(),
            RadioListTile(
              contentPadding: EdgeInsets.zero,
              value: "pay-on-delivery",
              title: const Text("Pay On Delivery"),
              groupValue: paymentMode,
              onChanged: (v) {
                paymentMode = v;
              },
            ),
            RadioListTile(
              contentPadding: EdgeInsets.zero,
              value: "pay-now",
              title: const Text("Pay Now"),
              groupValue: paymentMode,
              onChanged: (v) {
                paymentMode = v;
              },
            ),
            const Gap(),
            FilledButton(
              onPressed: () async {
                bool isSuccess =
                    await BlocProvider.of<OrderCubit>(context).createOrder(
                  items: BlocProvider.of<CartCubit>(context).state.cartItems,
                  paymentMethod: paymentMode!,
                );
                if (isSuccess) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).pushNamed(OrderPlacedPage.routeName);
                }
              },
              child: const Text("Place order"),
            ),
          ],
        ),
      ),
    );
  }
}
