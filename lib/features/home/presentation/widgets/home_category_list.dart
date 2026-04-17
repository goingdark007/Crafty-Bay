import 'package:flutter/material.dart';

import '../../../shared/presentation/widgets/category_card.dart';

class HomeCategoryList extends StatelessWidget {
  const HomeCategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (BuildContext context, int index){
          return CategoryCard();
        },
        separatorBuilder: (BuildContext context, int index){
          return const SizedBox(width: 8);
        },
      ),
    );
  }
}