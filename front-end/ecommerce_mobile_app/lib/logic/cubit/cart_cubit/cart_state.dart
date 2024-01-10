import 'package:ecommerce_mobile_app/data/models/cart_item_model.dart';

abstract class CartCubitState {
  final List<CartItemModel> cartItems;
  CartCubitState(this.cartItems);
}

class CartInitialState extends CartCubitState {
  CartInitialState() : super([]);
}

class CartLodingState extends CartCubitState {
  CartLodingState(super.cartItems);
}

class CartLoadedState extends CartCubitState {
  CartLoadedState(super.cartItems);
}

class CartErrorState extends CartCubitState {
  final String message;
  CartErrorState(this.message, super.cartItems);
}
