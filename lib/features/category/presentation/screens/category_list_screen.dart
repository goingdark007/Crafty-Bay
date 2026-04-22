import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../../auth/presentation/widgets/center_progress_indicator.dart";
import "../../../shared/presentation/providers/category_list_provider.dart";
import "../../../shared/presentation/providers/main_nav_provider.dart";
import "../../../shared/presentation/widgets/category_card.dart";

class CategoryListScreen extends StatefulWidget{

  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();

}

class _CategoryListScreenState extends State<CategoryListScreen> {

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll(){
    final provider = context.read<CategoryListProvider>();

    if (_scrollController.position.extentBefore < 300 && !provider.isLoading && provider.hasMore){
      provider.getCategories();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
          child: Consumer<CategoryListProvider>(
            builder: (context, provider, child) {

              if (provider.initialDataInProgress) return const CenterProgressIndicator();

              return Column(
                children: [
                  Expanded(
                    child: GridView.builder(

                        controller: _scrollController,
                        itemCount: provider.categoryList.length + 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 8,
                            childAspectRatio: 1,
                        ),
                        itemBuilder: (BuildContext context, int index){

                          return FittedBox(
                              child: CategoryCard(
                                categoryModel: provider.categoryList[index],
                              )
                          );

                        },
                    ),
                  ),
                  if(provider.moreDataInProgress) const CenterProgressIndicator()
                ],
              );
            }
          ),
        ),

      ),
    );

  }

}