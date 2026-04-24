import 'package:crafty_bay/features/product/data/models/product_model.dart';
import 'package:crafty_bay/features/product/presentation/screens/product_details_screen.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/app_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../../app/extensions/utils_extension.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key, required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, ProductDetailsScreen.routeName),
      child: SizedBox(
        width: 180,
        child: Card(
          elevation: 6,
          shadowColor: AppColors.themeColor.withAlpha(60),
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(16)
          ),
          child: Column(
            children: [
              Container(
                  height: 130,
                  width: 180,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: AppColors.themeColor.withAlpha(20),
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))
                  ),
                  child: AppNetworkImage(imageUrl: _getImage(productModel.images))
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(productModel.title,
                    maxLines: 1,
                    style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                        overflow: TextOverflow.ellipsis
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  child: Row(
                    spacing: 12,
                    mainAxisSize: .min,
                    children: [
                      const SizedBox(),
                      Text('${Constants.takaSign}${productModel.currentPrice}',
                        style: TextStyle(
                            color: AppColors.themeColor,
                            fontWeight: FontWeight.w500,
                            // fontSize: productModel.currentPrice > 4 ? 10 : 14
                        ),
                      ),
                      Wrap(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            Text('${productModel.rating}')
                          ]
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: AppColors.themeColor,
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: const Icon(Icons.favorite_border, color: Colors.white, size: 18),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),

            ],
          ),
        ),
      ),
    );
  }

  String _getImage(List<String> urls){
    return urls.isNotEmpty ? urls.first : '';
  }

}