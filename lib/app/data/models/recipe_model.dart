import 'ingredient_model.dart';

class Recipe {
  final int id;
  final String title;
  final String description;
  final String duration;
  final String servings;
  final String imageUrl;
  final List<String> mainIngredients;
  final List<Ingredient> allIngredients;
  final List<String> steps;
  double score; // <-- INI BARIS BARU YANG DITAMBAHKAN

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.servings,
    required this.imageUrl,
    required this.mainIngredients,
    required this.allIngredients,
    required this.steps,
    this.score = 0.0, // <-- NILAI AWAL UNTUK SCORE DITAMBAHKAN DI SINI
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    var allIngredientsFromJson = json['allIngredients'] as List;
    List<Ingredient> ingredientList = allIngredientsFromJson
        .map((i) => Ingredient.fromJson(i))
        .toList();

    return Recipe(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      duration: json['duration'],
      servings: json['servings'],
      imageUrl: json['imageUrl'],
      mainIngredients: List<String>.from(json['mainIngredients']),
      allIngredients: ingredientList,
      steps: List<String>.from(json['steps']),
    );
  }
}