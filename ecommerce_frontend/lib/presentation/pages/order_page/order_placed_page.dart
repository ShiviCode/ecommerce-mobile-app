import 'package:ecommerce_mobile_app/core/ui.dart';
import 'package:flutter/material.dart';

class OrderPlacedPage extends StatefulWidget {
    static const routeName = "Order-Placed-Page";
  const OrderPlacedPage({super.key});

  @override
  State<OrderPlacedPage> createState() => _OrderPlacedPageState();
}

class _OrderPlacedPageState extends State<OrderPlacedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Order-Placed"),
          ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(
                "Order Placed!!!",
                style: TextStyles.heading1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
