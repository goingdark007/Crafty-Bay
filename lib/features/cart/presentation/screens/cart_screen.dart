import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/providers/main_nav_provider.dart';
import '../widgets/bottom_card.dart';
import '../widgets/cart_product_list.dart';

class CartScreen extends StatelessWidget{

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'), // localization
        leading: IconButton(
            onPressed: () {
              context.read<MainNavProvider>().backToHome();
            },
            icon: Icon(Icons.arrow_back_ios)
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child: Column(
          crossAxisAlignment: .end,
          children: [
            CartProductList(),
            BottomCard()
          ],
        ),
      ),

    );

  }

}



