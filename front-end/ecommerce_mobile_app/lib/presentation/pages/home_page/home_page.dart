import 'package:ecommerce_mobile_app/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/cart_cubit/cart_state.dart';
import 'package:ecommerce_mobile_app/presentation/pages/cart_page/cart_page.dart';
import 'package:ecommerce_mobile_app/presentation/pages/home_page/category_segment.dart';
import 'package:ecommerce_mobile_app/presentation/pages/home_page/home_segment.dart';
import 'package:ecommerce_mobile_app/presentation/pages/home_page/profile_segement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List<Widget> segments = [
    const HomeSegment(),
    const CategorySegment(),
    const ProfileSegement()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ecommerce app"),
        actions: [
          IconButton(
            icon: BlocBuilder<CartCubit, CartCubitState>(
              builder: (context, state) {
                return Badge(
                  isLabelVisible: state is CartLodingState ? false : true,
                  label: Text(state.cartItems.length.toString()),
                  child: const Icon(Icons.shopping_cart),
                );
              },
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(CartPage.routeName);
            },
          ),
        ],
      ),
      body: segments[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Category"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
      ),
    );
  }
}
