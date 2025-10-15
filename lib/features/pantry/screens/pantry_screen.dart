import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../app/services/recommendation_service.dart';
import '../../../app/config/routes.dart';
import '../../recipe/screens/recipe_search_screen.dart';
import '../widgets/ingredient_tile.dart';
import '../../../app/widgets/custom_app_bar.dart';

class PantryScreen extends StatefulWidget {
  final String email;
  const PantryScreen({super.key, required this.email});

  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {
  final TextEditingController _ingredientController = TextEditingController();
  final Box<String> pantryBox = Hive.box<String>('pantryBox');
  bool _isLoading = false;

  void _addIngredient() {
    final ingredient = _ingredientController.text.trim();
    if (ingredient.isNotEmpty && !pantryBox.values.contains(ingredient)) {
      pantryBox.add(ingredient);
      _ingredientController.clear();
    }
  }

  void _removeIngredient(int index) {
    pantryBox.deleteAt(index);
  }

  Future<void> _searchRecipes() async {
    if (pantryBox.values.isEmpty) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tambahkan bahan dulu untuk mencari resep!')));
      return;
    }
    if (mounted) setState(() => _isLoading = true);
    final pantryItems = pantryBox.values.toList();
    final recommendations = await RecommendationService().getRecommendations(pantryItems);
    if (mounted) {
      setState(() => _isLoading = false);
      if (recommendations.isNotEmpty) {
        Navigator.pushNamed(context, AppRoutes.recipeListRoute, arguments: recommendations);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tidak ada resep yang cocok. Coba tambah bahan lain!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Pantry Saya',
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.profileRoute, arguments: widget.email),
          ),
          IconButton(
            icon: const Icon(Icons.menu_book),
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const RecipeSearchScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: animation.drive(Tween(begin: 0.5, end: 1.0).chain(CurveTween(curve: Curves.easeOut))),
                        child: child,
                      ),
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 300),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ingredientController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan bahan (e.g., nasi)',
                      border: OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.add),
                    ),
                    onSubmitted: (_) => _addIngredient(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: _addIngredient, child: const Text('Tambah')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              icon: _isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Icon(Icons.search),
              label: Text(_isLoading ? 'Mencari...' : 'Cari Resep'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: _isLoading ? null : _searchRecipes,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: pantryBox.listenable(),
              builder: (context, Box<String> box, _) {
                if (box.values.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.kitchen, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('Pantry kosong. Tambahkan bahan untuk mulai!'),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final ingredient = box.getAt(index)!;
                    return IngredientTile(
                      name: ingredient,
                      onDelete: () => _removeIngredient(index),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _ingredientController.dispose();
    super.dispose();
  }
}