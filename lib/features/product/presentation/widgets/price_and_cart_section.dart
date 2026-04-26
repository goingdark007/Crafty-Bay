import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/constants.dart';
import '../../../auth/presentation/widgets/center_progress_indicator.dart';
import '../providers/add_to_cart_provider.dart';

class PriceAndCartSection extends StatelessWidget {
  final int price;
  final VoidCallback onTap;
  const PriceAndCartSection({
    super.key,
    required this.price,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.themeColor.withAlpha(30),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Price',
                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),
              ),
              Text(
                '${Constants.takaSign}$price',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: Consumer<AddToCartProvider>(
              builder: (context, provider, _) {

                if(provider.inProgress) return CenterProgressIndicator();

                return FilledButton(onPressed: onTap, child: const Text('Add to Cart'));
              }
            ),
          ),
        ],
      ),
    );
  }
}