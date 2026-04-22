import 'package:crafty_bay/features/auth/presentation/widgets/center_progress_indicator.dart';
import 'package:crafty_bay/features/shared/presentation/providers/category_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/presentation/widgets/category_card.dart';

class HomeCategoryList extends StatefulWidget {
  const HomeCategoryList({
    super.key,
  });

  @override
  State<HomeCategoryList> createState() => _HomeCategoryListState();
}

class _HomeCategoryListState extends State<HomeCategoryList> {

  @override
  void initState() {
    super.initState();
    // Fetch first page on open
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp){
    //   context.read<CategoryListProvider>().getCategories();
    // });
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Consumer<CategoryListProvider>(
        builder: (context, provider, child) {

          // First load in progress
          if(provider.initialDataInProgress) return const CenterProgressIndicator();

          // First load failed
          if(provider.errorMessage != null && provider.categoryList.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(provider.errorMessage!),
                  ElevatedButton(
                    onPressed: provider.getCategories,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Data loaded, no pagination only show the first 10
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            // helper method for only showing the first 10 elements of the category list
            itemCount: _getCategoryLength(provider.categoryList.length),
            itemBuilder: (BuildContext context, int index){

              return CategoryCard(categoryModel: provider.categoryList[index]);

            },
            separatorBuilder: (BuildContext context, int index){
              return const SizedBox(width: 8);
            },
          );
        }
      ),
    );
  }

  // Defining a method for only showing the first 10 items in the list
  int _getCategoryLength(int length){
    return length > 10 ? 10 : length;
  }

}