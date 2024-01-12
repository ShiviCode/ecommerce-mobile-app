import 'package:ecommerce_mobile_app/data/models/category_model.dart';

abstract class CategoryState {
  final List<CategoryModel> categories;
  CategoryState(this.categories);
}

class CategoryInitialState extends CategoryState {
  CategoryInitialState() : super([]);
}

class CategoryLodingState extends CategoryState {
  CategoryLodingState(super.categories);
}

class CategoryLoadedState extends CategoryState {
  CategoryLoadedState(super.categories);
}

class CategoryErrorState extends CategoryState {
  final String message;
  CategoryErrorState(this.message, super.categories);
}
