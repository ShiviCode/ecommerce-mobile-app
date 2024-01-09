import 'package:ecommerce_mobile_app/data/models/cart_item_model.dart';
import 'package:ecommerce_mobile_app/data/repositories/cart_repository.dart';
import 'package:ecommerce_mobile_app/logic/cubit/Cart_cubit/Cart_state.dart';
import 'package:ecommerce_mobile_app/logic/cubit/user_cubit/user_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/user_cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// App State
class CartCubit extends Cubit<CartState> {
  final UserCubit _userCubit;
  CartCubit(this._userCubit) : super(CartInitialState()) {
    // listing to user cubit
    _userCubit.stream.listen((state) {
      if (state is UserLoggedInState) {
        _initialize(state.userModel.sId!);
      } else if (state is UserLoggedOutState) {
        emit(CartInitialState());
      }
    });
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
}
