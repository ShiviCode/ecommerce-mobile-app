import 'package:ecommerce_mobile_app/data/models/product_model.dart';

abstract class ProductState {
  final List<ProductModel> products;
  ProductState(this.products);
}

class ProductInitialState extends ProductState {
  ProductInitialState() : super([]);
}

class ProductLodingState extends ProductState {
  ProductLodingState(super.products);
}

class ProductLoadedState extends ProductState {
  ProductLoadedState(super.products);
}

class ProductErrorState extends ProductState {
  final String message;
  ProductErrorState(this.message, super.products);
}
