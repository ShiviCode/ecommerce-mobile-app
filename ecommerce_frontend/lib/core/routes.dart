import 'package:ecommerce_mobile_app/data/models/category_model.dart';
import 'package:ecommerce_mobile_app/data/models/product_model.dart';
import 'package:ecommerce_mobile_app/logic/cubit/category_product_cubit/category_product_cubit.dart';
import 'package:ecommerce_mobile_app/presentation/pages/cart_page/cart_page.dart';
import 'package:ecommerce_mobile_app/presentation/pages/home_page/home_page.dart';
import 'package:ecommerce_mobile_app/presentation/pages/login_page/login_page.dart';
import 'package:ecommerce_mobile_app/presentation/pages/product_details_page/product_details_page.dart';
import 'package:ecommerce_mobile_app/presentation/pages/product_page/category_product_page.dart';
import 'package:ecommerce_mobile_app/presentation/pages/splash_page.dart';
import 'package:ecommerce_mobile_app/presentation/providers/login_provider.dart';
import 'package:ecommerce_mobile_app/presentation/pages/login_page/signup_page.dart';
import 'package:ecommerce_mobile_app/presentation/providers/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashPage.routeName:
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case LoginPage.routeName:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<LoginProvider>(
            create: (context) => LoginProvider(context),
            child: const LoginPage(),
          ),
        );
      case SignupPage.routeName:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider<SignupProvider>(
            create: (context) => SignupProvider(context),
            child: const SignupPage(),
          ),
        );
      case HomePage.routeName:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case ProductDetailsPage.routeName:
        return MaterialPageRoute(
          builder: (_) => ProductDetailsPage(
            product: settings.arguments as ProductModel,
          ),
        );
      case CartPage.routeName:
        return MaterialPageRoute(
          builder: (_) => const CartPage(),
        );
      case CategoryProductPage.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CategoryProductCubit(
              settings.arguments as CategoryModel,
            ),
            child: CategoryProductPage(
              category: settings.arguments as CategoryModel,
            ),
          ),
        );

      default:
        return null; // error page
    }
  }
}
