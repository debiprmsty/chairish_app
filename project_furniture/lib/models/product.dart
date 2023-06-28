class Product {
  final int id;
  final String title;
  final String desc;
  final double price;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.desc,
    required this.price,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      desc: json['desc'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }
}
