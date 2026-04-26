import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/extensions/utils_extension.dart';
import '../../../shared/presentation/widgets/increment_decrement_button.dart';
import '../providers/product_details_provider.dart';
import '../widgets/color_picker.dart';
import '../widgets/price_and_cart_section.dart';
import '../widgets/product_image_carousel.dart';
import '../widgets/size_picker.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;
  const ProductDetailsScreen({super.key, required this.productId});

  static const String routeName = '/product-details';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ProductDetailsProvider>();
      if(provider.productDetails == null || provider.productId != widget.productId) {
      provider.getProductDetails(widget.productId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: Consumer<ProductDetailsProvider>(
        builder: (context, provider, child) {

          if (provider.getProductDetailsInProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.getErrorMessage != null) {
            return Center(child: Text(provider.getErrorMessage!));
          }

          if (provider.productDetails == null) {
            return const Center(child: Text('Product not found'));
          }

          final product = provider.productDetails!;

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProductImageCarousel(images: product.photos),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title,
                                        style: context.textTheme.bodyLarge
                                            ?.copyWith(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black87),
                                      ),
                                      Row(
                                        spacing: 6,
                                        children: [
                                          const Wrap(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 16,
                                                color: Colors.amber,
                                              ),
                                              Text('4.5'),
                                            ],
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            child: const Text('Reviews'),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: AppColors.themeColor,
                                              borderRadius: BorderRadius.circular(
                                                8,
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.favorite_outline,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                InDecButton(onChanged: (int value) {}),
                              ],
                            ),
                            const SizedBox(height: 16),
                            //if (product.colors.isNotEmpty)
                              ColorPicker(
                                initialValue: 'Red',//product.colors.first,
                                colors: ['Red', 'Blue', 'Green'],//product.colors,
                                onSelected: (String selectedColor) {},
                              ),
                            const SizedBox(height: 16),
                            //if (product.sizes.isNotEmpty)
                              SizePicker(
                                initialValue: 'S',//product.sizes.first,
                                sizes: ['S', 'M','L', 'XL'],//product.sizes,
                                onSelected: (String selectedColor) {},
                              ),
                            const SizedBox(height: 16),
                            Text(
                              'Description',
                              style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.black87),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              product.description,
                              style: const TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              PriceAndCartSection(price: product.currentPrice),
            ],
          );
        }
      ),
    );
  }
}