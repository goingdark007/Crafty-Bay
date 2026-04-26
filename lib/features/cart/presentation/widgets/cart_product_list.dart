import 'package:flutter/material.dart';

import '../../../../app/asset_paths.dart';
import '../../../../app/extensions/utils_extension.dart';
import '../../../shared/presentation/widgets/increment_decrement_button.dart';

class CartProductList extends StatelessWidget {
  const CartProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {

            return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1,
                        color: Colors.grey.shade300
                    )
                  ]
              ),
              child: Stack(
                children: [
                  ListTile(
                    leading: Image.asset(AssetPaths.shoePNG, width: 100, height: 100),
                    horizontalTitleGap: 5,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    title: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text('New Year Special Shoe', style: context.textTheme.titleMedium,),
                        Text('Color: Blue, Size: X', style: context.textTheme.bodyLarge,),
                        const SizedBox(height: 30)
                      ],
                    ),
                    subtitle: Text('\$100.00', style: context.textTheme.bodyMedium!.copyWith(fontWeight: .bold, fontSize: 18),),
                  ),
                  Positioned(
                    top: -1,
                    right: 1,
                    child: IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 6,
                    child: InDecButton(
                      maxValue: 10,
                      onChanged: (int value) {
                        debugPrint(value.toString());
                      },
                    ),
                  )
                ],
              ),
            );

          },
          separatorBuilder: (BuildContext context, int index){
            return const SizedBox(height: 15);
          },
        )
    );
  }
}

