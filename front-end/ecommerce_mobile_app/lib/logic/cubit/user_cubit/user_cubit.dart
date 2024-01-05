import 'package:ecommerce_mobile_app/data/models/user_model.dart';
import 'package:ecommerce_mobile_app/data/repositories/user_repositories.dart';
import 'package:ecommerce_mobile_app/logic/cubit/user_cubit/user_state.dart';
import 'package:ecommerce_mobile_app/logic/services/local_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// App State
class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialStete());
  final UserRepository _userRepository = UserRepository(); // service or api

  void emitUserLoggedInState(
      {required UserModel userModel,
      required String email,
      required String password}) async {
    await LocalStorage.saveUserDetails(email, password);
    emit(UserLoggedInState(userModel));
    print(email);
    print(password);
  }

  void signIn({required String email, required String password}) async {
    emit(UserLodingState());
    try {
      UserModel userModel = await _userRepository.signIn(
        //calling api method
        email: email,
        password: password,
      );
      // await LocalStorage.saveUserDetails(email, password);
      // emit(UserLoggedInState(userModel));
      emitUserLoggedInState(
        userModel: userModel,
        email: email,
        password: password,
      );
    } catch (e) {
      emit(
        UserErrorState(e.toString()), // Notifiying Listners
      );
    }
  }

  void createAccount({required String email, required String password}) async {
    emit(UserLodingState());
    try {
      UserModel userModel = await _userRepository.createAccount(
        //calling api method
        email: email,
        password: password,
      );
      // await LocalStorage.saveUserDetails(email, password);
      // emit(UserLoggedInState(userModel));
      emitUserLoggedInState(
        userModel: userModel,
        email: email,
        password: password,
      );
    } catch (e) {
      emit(
        UserErrorState(e.toString()), // Notifiying Listners
      );
    }
  }
}
