class Drink {
  final String name;
  final String image;
  final double price;  // You can use a default value for price

  Drink({required this.name, required this.image, required this.price});

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      name: json['strDrink'] ?? '',  // 'strDrink' is the name of the drink
      image: json['strDrinkThumb'] ?? '',  // 'strDrinkThumb' is the URL for the image
      price: 0.0,  // Price is not available in the API, set a default value
    );
  }
}
