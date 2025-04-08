class Wish {
  String id;
  String title;
  String description;
  double price;
  String? imagePath;
  bool isFulfilled;

  Wish({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.imagePath,
    this.isFulfilled = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'imagePath': imagePath,
      'isFulfilled': isFulfilled,
    };
  }

  factory Wish.fromMap(Map<String, dynamic> map) {
    return Wish(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      price: map['price'],
      imagePath: map['imagePath'],
      isFulfilled: map['isFulfilled'],
    );
  }
}
