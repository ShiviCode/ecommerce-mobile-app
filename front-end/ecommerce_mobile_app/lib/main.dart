import 'package:ecommerce_mobile_app/core/routes.dart';
import 'package:ecommerce_mobile_app/core/ui.dart';
import 'package:ecommerce_mobile_app/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/category_cubit/category_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/product_cubit/product_cubit.dart';
import 'package:ecommerce_mobile_app/logic/cubit/user_cubit/user_cubit.dart';
import 'package:ecommerce_mobile_app/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  //debugPaintSizeEnabled = true;
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => CategoryCubit()),
        BlocProvider(create: (context) => ProductCubit()),
        BlocProvider(
            create: (context) => CartCubit(BlocProvider.of<UserCubit>(context)))
      ],
      child: MaterialApp(
        theme: Themes.defaultTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: SplashPage.routeName,
        onGenerateRoute: Routes.onGenerateRoute,
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    print("Created: $bloc");
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    print("Change in: $bloc: $change");
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print("Transition change in: $bloc: $transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    print("Closed: $bloc");
    super.onClose(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print("Error in: $bloc: $error");
    super.onError(bloc, error, stackTrace);
  }
}
