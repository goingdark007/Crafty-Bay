import 'package:crafty_bay/features/shared/data/models/category_model.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/app_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/extensions/utils_extension.dart';
import '../../../product/presentation/screens/product_list_by_category.dart';

class CategoryCard extends StatelessWidget {

  const CategoryCard({
    super.key,
    required this.categoryModel
  });

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, ProductListByCategory.routeName, arguments: categoryModel.title);
      },
      child: Column(
        children: [
          Card(
            color: AppColors.themeColor.withAlpha(20),
            elevation: 0,
            child: SizedBox(
                width: 70,
                height: 60,
                child: AppNetworkImage(imageUrl: categoryModel.icon)
                // const Icon(Icons.laptop, size: 48, color: AppColors.themeColor)
            ),
          ),
          Text(getTitle(categoryModel.title),
            style: context.textTheme.bodyLarge?.copyWith(
                color: AppColors.themeColor,
                fontWeight: FontWeight.w600
            ),
          )
        ],
      ),
    );
  }

  String getTitle(String name){

    if(name.length > 9){
      return '${name.substring(0, 7)}...';
    }else{
      return name;
    }

  }

}