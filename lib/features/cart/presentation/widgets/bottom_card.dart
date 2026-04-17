import 'package:crafty_bay/app/extensions/utils_extension.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';

class BottomCard extends StatelessWidget {
  const BottomCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight:  Radius.circular(18)),
          color: AppColors.themeColor.withAlpha(30),
          boxShadow: [
            BoxShadow(
                color: AppColors.themeColor.withAlpha(20),
                //spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 4)
            )
          ]
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: .start,
            children: [
              Text('Total Price', style: context.textTheme.bodyLarge,),
              Text('\$100,000.00', style: context.textTheme.titleLarge!.copyWith(
                  color: AppColors.themeColor
                ),
              ),
            ],
          ),
          Spacer(),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.themeColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              ),
              onPressed: (){},
              child: Text('Checkout')
          )
        ],
      ),
    );
  }
}