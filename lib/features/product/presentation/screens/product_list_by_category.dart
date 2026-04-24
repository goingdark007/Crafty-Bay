import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../auth/presentation/widgets/center_progress_indicator.dart';
import '../../../shared/data/models/category_model.dart';
import '../../../shared/presentation/widgets/product_card.dart';
import '../providers/product_list_provider.dart';

class ProductListByCategory extends StatefulWidget{

  const ProductListByCategory({super.key, required this.categoryModel});

  static const String routeName = '/product-list';

  final CategoryModel categoryModel;

  @override
  State<ProductListByCategory> createState() => _ProductListByCategoryState();
}

class _ProductListByCategoryState extends State<ProductListByCategory> {

  final ProductListProvider _productListProvider = ProductListProvider();
  late final ScrollController _scrollController;


  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _productListProvider.getProducts(widget.categoryModel.id);
      _scrollController.addListener(_onScroll);
    });

  }

  void _onScroll() {

    bool isNearBottom = _scrollController.position.extentBefore < 300;

    if (isNearBottom && !_productListProvider.isLoading && _productListProvider.hasMore){
      _productListProvider.getProducts(widget.categoryModel.id);
    }

  }

  @override
  Widget build(BuildContext context){

    return ChangeNotifierProvider.value(
      value: _productListProvider,
      child: Scaffold(

        appBar: AppBar(
          title: Text(widget.categoryModel.title), // use localization logic if necessary
        ),

        body: Consumer<ProductListProvider>(
          builder: (context, provider, child) {

            if(provider.initialDataInProgress) return const CenterProgressIndicator();

            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                      controller: _scrollController,
                      itemCount: provider.productList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8
                      ),
                      itemBuilder: (BuildContext context, int index){
                        return FittedBox(
                          child: ProductCard(productModel: provider.productList[index],),
                        );
                      }

                  ),
                ),
                if(provider.moreDataInProgress) const LinearProgressIndicator()
              ],
            );
          }
        ),

      ),
    );
  }
}