class Ingredient {
  final String name;
  final String quantity; // Contoh: "200 gr", "1 siung", "secukupnya"

  Ingredient({
    required this.name,
    required this.quantity,
  });

  // Fungsi untuk mengubah dari format JSON ke objek Ingredient
  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'],
      quantity: json['quantity'],
    );
  }
}