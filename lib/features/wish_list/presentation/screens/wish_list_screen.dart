import 'package:crafty_bay/features/shared/presentation/providers/main_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatefulWidget{

  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context){
    
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, result) {

        context.read<MainNavProvider>().backToHome();

      },
      child: Scaffold(

        appBar: AppBar(
          title: Text('Wish List'),
          leading: IconButton(
              onPressed: () {
                context.read<MainNavProvider>().backToHome();
              },
              icon: Icon(Icons.arrow_back_ios)
          ),
        ),

        body: GridView.builder(
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8
            ),
            itemBuilder: (BuildContext context, int index){

              return FittedBox(
                child:  SizedBox() //ProductCard(),
              );

            }
        ),

      ),
    );

  }
}