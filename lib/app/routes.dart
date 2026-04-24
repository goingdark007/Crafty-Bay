import 'package:flutter/material.dart';
import '../features/auth/presentation/screens/sign_in_screen.dart';
import '../features/auth/presentation/screens/sign_up_screen.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/verify_otp_screen.dart';
import '../features/product/presentation/screens/product_details_screen.dart';
import '../features/product/presentation/screens/product_list_by_category.dart';
import '../features/shared/data/models/category_model.dart';
import '../features/shared/presentation/screens/main_nav_holder_screen.dart';

class Routes {

  static Route<dynamic> onGenerateRoute (RouteSettings settings) {

    late Widget widget;

    switch(settings.name){
      case SplashScreen.routeName:
        widget = SplashScreen();
        break;
      case SignUpScreen.routeName:
        widget = SignUpScreen();
        break;
      case SignInScreen.routeName:
        widget = SignInScreen();
        break;
      case VerifyOTPScreen.routeName:
        final email = settings.arguments as String; // getting the email from arguments
        widget = VerifyOTPScreen(email: email);
        break;
      case MainNavHolderScreen.routeName:
        widget = MainNavHolderScreen();
        break;
      case ProductListByCategory.routeName:
        final categoryModel = settings.arguments as CategoryModel;
        widget = ProductListByCategory(categoryModel: categoryModel);
        break;
      case ProductDetailsScreen.routeName:
        widget = ProductDetailsScreen();
        break;
      default:
        throw Exception('Route not Found');
    }

    return MaterialPageRoute(builder: (context) => widget, settings: settings);

  }

}