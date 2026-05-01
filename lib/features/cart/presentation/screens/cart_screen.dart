import 'package:crafty_bay/features/auth/presentation/widgets/center_progress_indicator.dart';
import 'package:crafty_bay/features/cart/data/models/cart_item_model.dart';
import 'package:crafty_bay/features/cart/presentation/providers/cart_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../auth/presentation/widgets/snack_bar_message.dart';
import '../../../shared/presentation/providers/main_nav_provider.dart';
import '../widgets/bottom_card.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatefulWidget{

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartListProvider _cartListProvider = CartListProvider();

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cartListProvider.getCartList();
    });
  }

  @override
  Widget build(BuildContext context){

    return ChangeNotifierProvider.value(
      value: _cartListProvider,
      child: Scaffold(
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
          child: Consumer<CartListProvider>(
            builder: (context, provider, _) {

            if(provider.inProgress) return const CenterProgressIndicator();

              return Column(
                crossAxisAlignment: .end,
                children: [
                  Expanded(
                      child: ListView.separated(
                        itemCount: provider.cartItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CartItems(
                            cartItemModel: provider.cartItems[index],
                          );
                          },
                        separatorBuilder: (BuildContext context, int index){
                          return const SizedBox(height: 15);
                          },
                      )
                  ),
                  BottomCard()
                ],
              );
            }
          ),
        ),

      ),
    );

  }

}



