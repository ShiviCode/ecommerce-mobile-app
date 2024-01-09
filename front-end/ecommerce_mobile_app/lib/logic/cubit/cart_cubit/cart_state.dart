import 'package:ecommerce_mobile_app/data/models/cart_item_model.dart';

abstract class CartState {
  final List<CartItemModel> cartItems;
  CartState(this.cartItems);
}

class CartInitialState extends CartState {
  CartInitialState() : super([]);
}

class CartLodingState extends CartState {
  CartLodingState(super.cartItems);
}

class CartLoadedState extends CartState {
  CartLoadedState(super.cartItems);
}

class CartErrorState extends CartState {
  final String message;
  CartErrorState(this.message, super.cartItems);
}
