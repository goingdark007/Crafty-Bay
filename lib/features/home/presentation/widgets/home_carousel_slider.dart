import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/features/shared/presentation/widgets/app_network_image.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../auth/presentation/widgets/center_progress_indicator.dart';
import '../providers/home_slider_provider.dart';

class HomeCarouselSlider extends StatefulWidget{
  const HomeCarouselSlider({super.key});

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {

  final ValueNotifier<int> _current = ValueNotifier(0);

  @override
  Widget build(BuildContext context){

    return Consumer<HomeSliderProvider>(
      builder: (context, homeSliderProvider, child) {

        if(homeSliderProvider.getHomeSliderInProgress) return const SizedBox(height: 210, child: CenterProgressIndicator());

        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  height: 200.0,
                  viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  _current.value = index;
                },
              ),
              items: homeSliderProvider.homeSliders.map((slider) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.sizeOf(context).width,
                      margin: const EdgeInsets.symmetric(horizontal: 2.0),
                      // decoration: BoxDecoration(
                      //     color: Colors.blue,
                      //     borderRadius: BorderRadius.circular(8),
                      // ),
                      alignment: Alignment.center,
                      child: AppNetworkImage(
                          imageUrl: slider.photoUrl,
                          fit: BoxFit.cover,
                          borderRadius: 8,
                          height: MediaQuery.sizeOf(context).height,
                          width: MediaQuery.sizeOf(context).width,
                      )
                    );
                  }
                );
              }).toList(),
            ),
            const SizedBox(height: 8,),
            ValueListenableBuilder(
              valueListenable: _current,
              builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 3.8,
                  children: [
                    for(int i=0; i< homeSliderProvider.homeSliders.length; i++)
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: value == i ? AppColors.themeColor : Colors.transparent,
                          border: Border.all(color: value == i ? AppColors.themeColor : Colors.grey)
                        ),
                      )
                  ],
                );
              }
            )
          ],
        );
      }
    );

  }
}