import 'dart:async';

import 'package:ecommerce_mobile_app/data/models/cart_item_model.dart';
import 'package:ecommerce_mobile_app/data/repositories/cart_repository.dart';
import 'package:ecommerce_mobile_app/logic/cubit/Cart_cubit/Cart_state.dart';
import 'package:ecommerce_mobile_app/logic/cubit/user_cubit/user_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/user_cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// App State
class CartCubit extends Cubit<CartState> {
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
      emit(CartLoadedState(items));
    } catch (ex) {
      emit(
        CartErrorState(ex.toString(), state.cartItems),
      );
    }
  }

  // @override
  // Future<void> close() {
  //   _userSubscription?.cancel();
  //   return super.close();
  //   // closing connection to user cubit stream
  // }
}
