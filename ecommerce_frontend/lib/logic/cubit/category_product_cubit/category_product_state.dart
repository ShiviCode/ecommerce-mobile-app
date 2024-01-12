import 'package:ecommerce_mobile_app/data/models/product_model.dart';

abstract class CategoryProductState {
  final List<ProductModel> products;
  CategoryProductState(this.products);
}

class CategoryProductInitialState extends CategoryProductState {
  CategoryProductInitialState() : super([]);
}

class CategoryProductLodingState extends CategoryProductState {
  CategoryProductLodingState(super.products);
}

class CategoryProductLoadedState extends CategoryProductState {
  CategoryProductLoadedState(super.products);
}

class CategoryProductErrorState extends CategoryProductState {
  final String message;
  CategoryProductErrorState(this.message, super.products);
}
