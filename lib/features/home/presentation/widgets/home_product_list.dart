import 'package:flutter/material.dart';


class HomeProductList extends StatelessWidget {
  const HomeProductList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (BuildContext context, int index){
          return  SizedBox(); //ProductCard();
        },
        separatorBuilder: (BuildContext context, int index){
          return const SizedBox(width: 16);
        },

      ),
    );
  }
}