import 'package:ecommerce_mobile_app/data/models/user_model.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLodingState extends UserState {}

class UserLoggedInState extends UserState {
  final UserModel userModel;
  UserLoggedInState(this.userModel);
}

class UserLoggedOutState extends UserState {}

class UserErrorState extends UserState {
  final String message;
  UserErrorState(this.message);
}
