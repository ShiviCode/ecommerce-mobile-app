import 'dart:async';

import 'package:ecommerce_mobile_app/logic/cubit/user_cubit/user_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/user_cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Local state
class LoginProvider extends ChangeNotifier {
  final BuildContext context; // context to access bloc
  LoginProvider(this.context) {
    _listenToUserCubit();
  }

  bool isLoding = false;
  String error = "";
  StreamSubscription? _userSubscription;

  void _listenToUserCubit() {
    //print('listdgy');
    // Listing to user cubit stream
    _userSubscription =
        BlocProvider.of<UserCubit>(context).stream.listen((userState) {
      // Loding
      if (userState is UserLodingState) {
        isLoding = true;
        notifyListeners();
      }
      // Error
      if (userState is UserErrorState) {
        isLoding = false;
        error = userState.message;
        notifyListeners();
      }
      // Success
      else {
        isLoding = false;
        error = "";
        notifyListeners();
      }
    });
  }

  void login(
      {required bool isValid,
      required String email,
      required String password}) async {
    if (!isValid) return;
    BlocProvider.of<UserCubit>(context)
        .signIn(email: email, password: password);
  }

  @override
  void dispose() {
    super.dispose();
    // closing connection to user cubit stream
    _userSubscription?.cancel();
  }
}
