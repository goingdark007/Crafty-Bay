import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/extensions/utils_extension.dart';
import '../../../shared/presentation/providers/main_nav_provider.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_carousel_slider.dart';
import '../widgets/home_category_list.dart';
import '../widgets/home_product_list.dart';
import '../widgets/product_search_bar.dart';
import '../widgets/section_header.dart';

class HomeScreen extends StatefulWidget{

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  @override
  Widget build(BuildContext context){

    return Scaffold(

      appBar: HomeAppBar(),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              ProductSearchBar(),
              const SizedBox(height: 10),
              HomeCarouselSlider(),
              const SizedBox(height: 18),
              SectionHeader(title: context.l10n.homeScreenCategory, onTapSeeAll: (){
                context.read<MainNavProvider>().moveToCategory();
              }),
              HomeCategoryList(),
              const SizedBox(height: 8),
              SectionHeader(title: context.l10n.homePopular, onTapSeeAll: (){}),
              HomeProductList(),
              const SizedBox(height: 8),
              SectionHeader(title: 'Special', onTapSeeAll: (){}),
              HomeProductList(),
              const SizedBox(height: 8),
              SectionHeader(title: 'New', onTapSeeAll: (){}),
              HomeProductList(),
              const SizedBox(width: 8),
            ]
          ),
        ),
      )

    );
  }
}
