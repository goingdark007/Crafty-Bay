class ProductModel {

  final String id;
  final String title;
  final int currentPrice;
  final double rating;
  final List<String> images;

  ProductModel({
    required this.id,
    required this.title,
    required this.currentPrice,
    required this.rating,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json){

    return ProductModel(
        id: json["_id"],
        title: json["title"],
        currentPrice: json["current_price"],
        rating: json["rating"] ?? 4.0,
        images: List.from(json['photos'])
    );

  }

  Map<String, dynamic> toJson(){

    return {
      '_id' : id,
      'title' : title,
      'current_price' : currentPrice,
      'rating' : rating,
      'photos' : images
    };

  }

}