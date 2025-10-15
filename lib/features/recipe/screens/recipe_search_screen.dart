import 'package:flutter/material.dart';
import '../../../app/data/models/recipe_model.dart';
import '../../../app/services/recommendation_service.dart';
import '../widgets/recipe_card.dart';

class RecipeSearchScreen extends StatefulWidget {
  const RecipeSearchScreen({super.key});
  @override
  State<RecipeSearchScreen> createState() => _RecipeSearchScreenState();
}

class _RecipeSearchScreenState extends State<RecipeSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Recipe> _allRecipes = [];
  List<Recipe> _filteredRecipes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAllRecipes();
    _searchController.addListener(_filterRecipes);
  }

  Future<void> _loadAllRecipes() async {
    final recipes = await RecommendationService().getAllRecipes();
    if (mounted) setState(() { _allRecipes = recipes; _filteredRecipes = recipes; _isLoading = false; });
  }

  void _filterRecipes() {
    final query = _searchController.text;
    setState(() {
      _filteredRecipes = query.isEmpty ? _allRecipes : _allRecipes.where((r) => r.title.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(hintText: 'Cari nama resep...', hintStyle: TextStyle(color: Colors.white70), border: InputBorder.none),
        ),
        actions: [IconButton(icon: const Icon(Icons.clear), onPressed: () => _searchController.clear())],
      ),
      body: _isLoading ? const Center(child: CircularProgressIndicator())
          : _filteredRecipes.isEmpty ? const Center(child: Text('Resep tidak ditemukan.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: _filteredRecipes.length,
                  itemBuilder: (context, index) => RecipeCard(recipe: _filteredRecipes[index]),
                ),
    );
  }
}