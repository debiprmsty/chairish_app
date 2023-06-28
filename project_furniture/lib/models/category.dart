class Category {
  final int id;
  final String category_name;

  Category({
    required this.id,
    required this.category_name,
  });

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      id: json['id'],
      category_name: json['category_name']
    );
  }
}