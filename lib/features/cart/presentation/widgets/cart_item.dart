import 'package:crafty_bay/app/constants.dart';
import 'package:crafty_bay/features/auth/presentation/widgets/snack_bar_message.dart';
import 'package:crafty_bay/features/cart/presentation/providers/cart_list_provider.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/extensions/utils_extension.dart';
import '../../../shared/presentation/widgets/increment_decrement_button.dart';
import '../../data/models/cart_item_model.dart';

class CartItems extends StatefulWidget {
  const CartItems({
    super.key,
    required this.cartItemModel,
  });

  final CartItemModel cartItemModel;

  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  @override
  Widget build(BuildContext context) {

    final cartListProvider = context.read<CartListProvider>();

    return Container(
      decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 1,
                color: Colors.grey.shade300,
            )
          ]
      ),
      child: Stack(
        children: [
          ListTile(
            leading: SizedBox(width: 100),
            horizontalTitleGap: 5,
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            title: Column(
              crossAxisAlignment: .start,
              children: [
                Text(widget.cartItemModel.productModel.title, style: context.textTheme.titleMedium,),
                Text('Color: ${widget.cartItemModel.color ?? 'N/A'}, Size: ${widget.cartItemModel.size ?? 'N/A'}', style: context.textTheme.bodyLarge,),
                const SizedBox(height: 30)
              ],
            ),
            subtitle: Text('${Constants.takaSign}${cartListProvider.productPriceByCartId(widget.cartItemModel.id)}', style: context.textTheme.bodyMedium!.copyWith(fontWeight: .bold, fontSize: 18),),
          ),
          Positioned(
              top: 30,
              left: 2,
              child: AppNetworkImage(
                  imageUrl: _getImage(widget.cartItemModel.productModel.images),
                  width: 100,
                  fit: BoxFit.contain
              )
          ),
          Positioned(
            top: 5,
            right: 1,
            child: IconButton(
                onPressed: () => _deleteCartItem(widget.cartItemModel.id),
                icon: Icon(Icons.delete)),
          ),
          Positioned(
            bottom: 8,
            right: 6,
            child: InDecButton(
              maxValue: 5,//cartItemModel.productModel.quantity,
              onChanged: (int value) {
                debugPrint(value.toString());
                cartListProvider.updateCartItemQuantity(widget.cartItemModel.id, value);
              },
            ),
          )
        ],
      ),
    );
  }

  String _getImage(List<String> urls){
    return urls.isNotEmpty ? urls.first : '';
  }

  Future<void> _deleteCartItem(String cartId) async {

    final cartListProvider = context.read<CartListProvider>();

    final bool isSuccess = await cartListProvider.deleteCartItem(cartId);

    if(!mounted) return;
    if(isSuccess){
      showSnackBarMessage(
          context: context,
          message: 'Cart item deleted successfully',
          color: Colors.green
      ) ;
    } else {
      showSnackBarMessage(
          context: context,
          message: cartListProvider.errorMessage ?? 'Failed to delete cart item',
          color: Colors.redAccent
      ) ;
    }
  }

}