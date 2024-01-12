import 'package:ecommerce_mobile_app/logic/cubit/user_cubit/user_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/user_cubit/user_state.dart';
import 'package:ecommerce_mobile_app/presentation/pages/home_page/home_page.dart';
import 'package:ecommerce_mobile_app/presentation/pages/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  static const routeName = "splash";
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void _goToNextPage() {
    var userState = BlocProvider.of<UserCubit>(context).state;
    if (userState is UserLoggedInState) {
       Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    } else if (userState is UserLoggedOutState) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
    } else if (userState is UserErrorState) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _goToNextPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        _goToNextPage();
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
