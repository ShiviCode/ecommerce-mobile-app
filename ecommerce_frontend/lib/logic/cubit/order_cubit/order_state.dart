import 'package:ecommerce_mobile_app/data/models/order_model.dart';

abstract class OrderState {
  final List<OrderModel> orders;
  OrderState(this.orders);
}

class OrderInitialState extends OrderState {
  OrderInitialState() : super([]);
}

class OrderLodingState extends OrderState {
  OrderLodingState(super.orders);
}

class OrderLoadedState extends OrderState {
  OrderLoadedState(super.orders);
}

class OrderErrorState extends OrderState {
  final String message;
  OrderErrorState(this.message, super.orders);
}
