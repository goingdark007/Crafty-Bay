import 'package:crafty_bay/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/controllers/auth_controller.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../../category/presentation/screens/category_list_screen.dart';
import '../../../home/presentation/providers/home_slider_provider.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../wish_list/presentation/screens/wish_list_screen.dart';
import '../providers/category_list_provider.dart';
import '../providers/main_nav_provider.dart';

class MainNavHolderScreen extends StatefulWidget{

  const MainNavHolderScreen({super.key});

  static const String routeName = '/main-nav-holder';

  @override
  State<MainNavHolderScreen> createState() => _MainNavHolderScreenState();
}

class _MainNavHolderScreenState extends State<MainNavHolderScreen> {

  static const List<Widget> _screens = [
    HomeScreen(),
    CategoryListScreen(),
    CartScreen(),
    WishListScreen(),
  ];


  @override
  void initState(){
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) async {
      await context.read<HomeSliderProvider>().getHomeSlider();
      if(!mounted) return;
      await context.read<CategoryListProvider>().getCategories();
    });

  }


  @override
  Widget build(BuildContext context){

    final mainNavProvider = context.watch<MainNavProvider>();

    return Scaffold(

      body: _screens[mainNavProvider.currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        // selectedItemColor: AppColors.themeColor,
        // unselectedItemColor: Colors.grey,
        // showUnselectedLabels: true,
        onTap: (int index) async {
          if(mainNavProvider.shouldCheckUserLoggedIn(index)){
            final isLoggedIn = await AuthController.isLoggedIn();
            if(isLoggedIn == false ) {
              if(!context.mounted) return;
              Navigator.pushNamed(context, SignInScreen.routeName);
              return;
            }
          }
          mainNavProvider.changeIndex(index);
        },
        currentIndex: mainNavProvider.currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined), label: 'Profile')
        ]
      ),

    );

  }

}