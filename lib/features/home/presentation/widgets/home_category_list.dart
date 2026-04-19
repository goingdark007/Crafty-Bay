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

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Fetch first page on open
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp){
    //   context.read<CategoryListProvider>().getCategories();
    // });

    // Listen for scroll, trigger load more near the bottom
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final provider = context.read<CategoryListProvider>();

    // When user is within 200 pixels from the bottom, load more
    final bool isNearBottom = _scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200;

    if (isNearBottom && !provider.isLoading && provider.hasMore) {
      provider.getCategories();
    }

  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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

          // Data loaded
          return RefreshIndicator(
            onRefresh: provider.refreshCategories,
            child: ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              // + 1 for loading indicator at the bottom
              itemCount: provider.categoryList.length + 1,
              itemBuilder: (BuildContext context, int index){

                // Last item (footer)
                if (index == provider.categoryList.length) {

                  // Loading more
                  if (provider.moreDataInProgress) {
                    return const SizedBox(
                      width: 80, // IMPORTANT
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  // No more data
                  if (!provider.hasMore) {
                    return SizedBox(
                      width: 80, // IMPORTANT
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: Text('No more categories')),
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                }

                return CategoryCard(categoryModel: provider.categoryList[index]);
              },
              separatorBuilder: (BuildContext context, int index){
                return const SizedBox(width: 8);
              },
            ),
          );
        }
      ),
    );
  }
}