import 'package:ecommerce_mobile_app/data/models/category_model.dart';
import 'package:ecommerce_mobile_app/data/repositories/category_repository.dart';
import 'package:ecommerce_mobile_app/logic/cubit/category_cubit/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// App State
class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitialState()) {
    _initialize();
  }

  final CategoryRepository _categoryRepository =
      CategoryRepository(); // service or api

  void _initialize() async {
    emit(CategoryLodingState(state.categories));
    try {
      List<CategoryModel> categories =
          await _categoryRepository.fetchAllCategories();
      emit(CategoryLoadedState(categories));
    } catch (ex) {
      emit(
        CategoryErrorState(ex.toString(), state.categories),
      );
    }
  }
}
