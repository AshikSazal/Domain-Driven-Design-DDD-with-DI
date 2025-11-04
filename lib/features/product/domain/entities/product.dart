class Product {
  final String id;
  final String name;
  final double price;

  const Product({
    required this.id,
    required this.name,
    required this.price,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'price': price,
  };

  factory Product.fromMap(Map<String, dynamic> map) => Product(
    id: map['id'],
    name: map['name'],
    price: (map['price'] as num).toDouble(),
  );
}
