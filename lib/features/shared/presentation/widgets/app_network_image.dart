import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'no_image.dart';

class AppNetworkImage extends StatelessWidget{

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit,
    this.borderRadius
  });

  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final double? borderRadius;


  @override
  Widget build(BuildContext context){

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: width,
          fit: fit ?? BoxFit.cover,
          placeholder: (context, url) => const NoImage(),
          errorWidget: (context, url, error) => const Icon(Icons.broken_image),
      ),
    );

  }

}