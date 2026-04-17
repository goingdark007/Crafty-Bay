class CategoryModel {
  final String id;
  final String title;
  final String description;
  final String icon;

  CategoryModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "icon": icon,
  };
}
