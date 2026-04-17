import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../../shared/presentation/providers/main_nav_provider.dart";
import "../../../shared/presentation/widgets/category_card.dart";

class CategoryListScreen extends StatefulWidget{

  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();

}

class _CategoryListScreenState extends State<CategoryListScreen> {
  @override
  Widget build(BuildContext context){

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, result) {
        context.read<MainNavProvider>().backToHome();
      },
      child: Scaffold(

        appBar: AppBar(
          title: const Text('Categories'), // localization .categoryScreenTitle
          leading: IconButton(
              onPressed: () {
                context.read<MainNavProvider>().backToHome();
              },
              icon: Icon(Icons.arrow_back_ios)
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(

              itemCount: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
              ),
              itemBuilder: (BuildContext context, int index){

                return FittedBox(
                    child: CategoryCard()
                );

              },
          ),
        ),

      ),
    );

  }




}

