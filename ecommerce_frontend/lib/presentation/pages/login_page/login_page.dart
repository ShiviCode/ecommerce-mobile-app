import 'package:ecommerce_mobile_app/core/ui.dart';
import 'package:ecommerce_mobile_app/logic/cubit/user_cubit/user_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/user_cubit/user_state.dart';
import 'package:ecommerce_mobile_app/presentation/pages/splash_page.dart';
import 'package:ecommerce_mobile_app/presentation/providers/login_provider.dart';
import 'package:ecommerce_mobile_app/presentation/pages/login_page/signup_page.dart';
import 'package:ecommerce_mobile_app/widgets/gap_widget.dart';
import 'package:ecommerce_mobile_app/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/login";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordVisible = true;
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginProvider>(context);
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        // Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushNamed(SplashPage.routeName);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Ecommerce App"),
        ),
        body: SafeArea(
            child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Log In',
                style: TextStyles.heading1,
              ),
              const Gap(),
              PrimaryTextField(
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Email can't be empty";
                  } else if (!(RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(v))) {
                    return "Invalid email";
                  }
                  return null;
                },
                controller: emailController,
                labelText: "Email Address",
              ),
              const Gap(),
              PrimaryTextField(
                  suffix: GestureDetector(
                    onTap: () {
                      isPasswordVisible = !isPasswordVisible;
                      setState(() {});
                    },
                    child: Icon(
                      isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.textLight,
                    ),
                  ),
                  obscureText: isPasswordVisible,
                  controller: passwordController,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Password can't be empty";
                    } else if (!(v.length >= 6)) {
                      return "Password must be 6 characters long";
                    }
                    return null;
                  },
                  labelText: "password"),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text(
                      'Forgot Password?',
                      style: TextStyles.body2.copyWith(color: AppColors.accent),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              const Gap(),
              loginProvider.error == ""
                  ? const SizedBox()
                  : Text(
                      loginProvider.error,
                      style: TextStyles.body2.copyWith(color: Colors.red),
                    ),
              FilledButton(
                onPressed: loginProvider.isLoding
                    ? null
                    : () {
                        loginProvider.login(
                            isValid: formKey.currentState!.validate(),
                            email: emailController.text,
                            password: passwordController.text);
                      },
                child: Text(loginProvider.isLoding ? '...' : 'Log in'),
              ),
              const Gap(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyles.body2,
                  ),
                  TextButton(
                    child: Text(
                      'Sign up',
                      style: TextStyles.body2.copyWith(color: AppColors.accent),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(SignupPage.routeName);
                    },
                  ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
