import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../data/models/recipe_model.dart';

class RecommendationService {
  // Fungsi untuk memuat semua resep tanpa filter.
  Future<List<Recipe>> getAllRecipes() async {
    return await _loadRecipes();
  }

  // Fungsi untuk mendapatkan rekomendasi berdasarkan bahan.
  Future<List<Recipe>> getRecommendations(List<String> pantryIngredients) async {
    final List<Recipe> allRecipes = await _loadRecipes();

    for (var recipe in allRecipes) {
      recipe.score = _calculateScore(pantryIngredients, recipe.mainIngredients);
    }

    allRecipes.sort((a, b) => b.score.compareTo(a.score));
    
    final recommendedRecipes = allRecipes.where((r) => r.score > 0).toList();
    return recommendedRecipes;
  }

  double _calculateScore(List<String> pantry, List<String> recipeIngredients) {
    if (recipeIngredients.isEmpty) return 0;
    int matchCount = 0;
    for (String pantryItem in pantry) {
      if (recipeIngredients.any((recipeItem) => recipeItem.toLowerCase() == pantryItem.toLowerCase())) {
        matchCount++;
      }
    }
    return matchCount / recipeIngredients.length;
  }

  Future<List<Recipe>> _loadRecipes() async {
    final String jsonString = await rootBundle.loadString('assets/data/initial_recipes.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Recipe.fromJson(json)).toList();
  }
}