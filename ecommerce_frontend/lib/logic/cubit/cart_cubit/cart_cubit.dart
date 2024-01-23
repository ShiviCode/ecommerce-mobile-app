import 'dart:async';

import 'package:ecommerce_mobile_app/data/models/cart_item_model.dart';
import 'package:ecommerce_mobile_app/data/models/product_model.dart';
import 'package:ecommerce_mobile_app/data/repositories/cart_repository.dart';
import 'package:ecommerce_mobile_app/logic/cubit/cart_cubit/cart_state.dart';
import 'package:ecommerce_mobile_app/logic/cubit/user_cubit/user_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/user_cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// App State
class CartCubit extends Cubit<CartCubitState> {
  final UserCubit _userCubit;
  StreamSubscription? _userSubscription;
  CartCubit(this._userCubit) : super(CartInitialState()) {
    // inital value
    _handleUserState(_userCubit.state);
    // listing to user cubit
    _userSubscription = _userCubit.stream.listen(//(state) {
        _handleUserState // }
        );
  }

  void sortAndLoad(List<CartItemModel> items) {
    items.sort((a, b) => b.product.title.compareTo(b.product.title));
    emit(CartLoadedState(items));
  }

  void _handleUserState(UserState userstate) {
    if (userstate is UserLoggedInState) {
      _initialize(userstate.userModel.sId!);
    } else if (userstate is UserLoggedOutState) {
      emit(CartInitialState());
    }
  }

  final CartRepository _cartRepository = CartRepository(); // service or api

  void _initialize(String userId) async {
    emit(CartLodingState(state.cartItems));
    try {
      List<CartItemModel> items =
          await _cartRepository.fetchCartForUser(userId);
      sortAndLoad(items);
    } catch (ex) {
      emit(
        CartErrorState(ex.toString(), state.cartItems),
      );
    }
  }

  void addToCart(ProductModel product, int quantity) async {
    emit(CartLodingState(state.cartItems));
    try {
      if (_userCubit.state is UserLoggedInState) {
        UserLoggedInState userSate = _userCubit.state as UserLoggedInState;
        CartItemModel newItem =
            CartItemModel(product: product, quantity: quantity);
        var updatedItem =
            await _cartRepository.addToCart(newItem, userSate.userModel.sId!);
        sortAndLoad(updatedItem);
        // emit(CartLoadedState(updatedItem));
      } else {
        throw "An Exception";
      }
    } catch (ex) {
      emit(
        CartErrorState(ex.toString(), state.cartItems),
      );
    }
  }

  bool cartContains(ProductModel product) {
    if (state.cartItems.isNotEmpty) {
      // print(state.cartItems.isEmpty);
      final foundItem = state.cartItems
          .where((item) => item.product.sId! == product.sId)
          .toList();

      if (foundItem.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void removeFromCart(ProductModel product) async {
    emit(CartLodingState(state.cartItems));
    try {
      if (_userCubit.state is UserLoggedInState) {
        UserLoggedInState userSate = _userCubit.state as UserLoggedInState;

        var updatedItem = await _cartRepository.removeFromCart(
            userSate.userModel.sId!, product.sId!);
        sortAndLoad(updatedItem);
        // emit(CartLoadedState(updatedItem));
      } else {
        throw "An error occured while removing the item";
      }
    } catch (ex) {
      emit(
        CartErrorState(ex.toString(), state.cartItems),
      );
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
    // closing connection to user cubit stream
  }
}
