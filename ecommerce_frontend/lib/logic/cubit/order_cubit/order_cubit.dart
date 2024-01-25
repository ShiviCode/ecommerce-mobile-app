import 'dart:async';

import 'package:ecommerce_mobile_app/data/models/cart_item_model.dart';
import 'package:ecommerce_mobile_app/data/models/order_model.dart';
import 'package:ecommerce_mobile_app/data/repositories/order_repository.dart';
import 'package:ecommerce_mobile_app/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/order_cubit/order_state.dart';
import 'package:ecommerce_mobile_app/logic/cubit/user_cubit/user_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/user_cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// App State
class OrderCubit extends Cubit<OrderState> {
  final UserCubit _userCubit;
  final CartCubit _cartCubit;
  StreamSubscription? _userSubscription;
  OrderCubit(this._userCubit, this._cartCubit) : super(OrderInitialState()) {
    _handleUserState(_userCubit.state);
    // listing to user cubit
    _userSubscription = _userCubit.stream.listen(//(state) {
        _handleUserState // }
        );
  }

  void _handleUserState(UserState userstate) {
    if (userstate is UserLoggedInState) {
      _initialize(userstate.userModel.id!);
    } else if (userstate is UserLoggedOutState) {
      emit(OrderInitialState());
    }
  }

  final OrderRepository _orderRepository = OrderRepository(); // service or api

  void _initialize(String userId) async {
    emit(OrderLodingState(state.orders));

    try {
      final orders = await _orderRepository.fetchOrdersForUser(userId);
      emit(OrderLoadedState(orders));
    } catch (ex) {
      emit(
        OrderErrorState(ex.toString(), state.orders),
      );
    }
  }

  Future<bool> createOrder(
      {required List<CartItemModel> items,
      required String paymentMethod}) async {
    emit(OrderLodingState(state.orders));

    try {
      if (_userCubit.state is! UserLoggedInState) return false;

      OrderModel newOrder = OrderModel(
          items: items,
          user: (_userCubit.state as UserLoggedInState).userModel,
          status: paymentMethod == "pay-on-delivery"
              ? "Order-placed"
              : "Payment-pending"
              );

      final order = await _orderRepository.createOrder(newOrder);
      List<OrderModel> ordersList = [order, ...state.orders];

      emit(OrderLoadedState(ordersList));
      // clear the cart
      _cartCubit.clearCart();
      return true;
    } catch (ex) {
      emit(
        OrderErrorState(ex.toString(), state.orders),
      );
      return false;
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
    // closing connection to user cubit stream
  }
}
