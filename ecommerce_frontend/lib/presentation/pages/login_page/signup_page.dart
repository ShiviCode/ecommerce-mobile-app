import 'package:ecommerce_mobile_app/core/ui.dart';
import 'package:ecommerce_mobile_app/presentation/providers/signup_provider.dart';
import 'package:ecommerce_mobile_app/widgets/gap_widget.dart';
import 'package:ecommerce_mobile_app/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  static const routeName = "/signup";
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isPasswordVisible = true;
  bool isCPasswordVisible = true;
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var signupProvider = Provider.of<SignupProvider>(context);
    return Scaffold(
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
                    isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.textLight,
                  ),
                ),
                controller: passwordController,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Password can't be empty";
                  } else if (!(v.length >= 6)) {
                    return "Password must be 6 characters long";
                  }
                  return null;
                },
                obscureText: isPasswordVisible,
                labelText: "Password"),
            const Gap(),
            PrimaryTextField(
                suffix: GestureDetector(
                  onTap: () {
                    isCPasswordVisible = !isCPasswordVisible;
                    setState(() {});
                  },
                  child: Icon(
                    isCPasswordVisible ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.textLight,
                  ),
                ),
                controller: cPasswordController,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Password can't be empty";
                  } else if (!(v.length >= 6)) {
                    return "Password must be 6 characters long";
                  }
                  if (v != passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
                obscureText: isCPasswordVisible,
                labelText: "Confirm password"),
            const Gap(),
            signupProvider.error == ""
                ? const SizedBox()
                : Text(
                    signupProvider.error,
                    style: TextStyles.body2.copyWith(color: Colors.red),
                  ),
            FilledButton(
              onPressed: signupProvider.isLoding
                  ? null
                  : () {
                      signupProvider.createAccount(
                          isValid: formKey.currentState!.validate(),
                          email: emailController.text,
                          password: passwordController.text);
                    },
              child: Text(signupProvider.isLoding ? '...' : 'Create Account'),
            ),
            const Gap(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyles.body2,
                ),
                TextButton(
                  child: Text(
                    'Log In',
                    style: TextStyles.body2.copyWith(color: AppColors.accent),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
