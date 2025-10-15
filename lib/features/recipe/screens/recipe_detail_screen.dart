import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../app/data/models/recipe_model.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                recipe.title,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: recipe.imageUrl,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.broken_image, size: 100, color: Colors.grey),
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black54,
                        ],
                        stops: [0.6, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.description,
                        style: const TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      const Divider(height: 32),
                      const Text(
                        'Bahan-bahan',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      
                      // --- PERUBAHAN UTAMA DI SINI ---
                      for (var ingredient in recipe.allIngredients)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Text('• ${ingredient.quantity} ${ingredient.name}'),
                              const SizedBox(width: 8),
                              // Cek apakah nama bahan (setelah dibersihkan) ada di daftar mainIngredients
                              if (recipe.mainIngredients.any((mainIngredient) => 
                                  ingredient.name.toLowerCase().contains(mainIngredient.toLowerCase())))
                                const Icon(Icons.star, color: Colors.amber, size: 16),
                            ],
                          ),
                        ),
                      // ---------------------------------
                        
                      const Divider(height: 32),
                      const Text(
                        'Langkah-langkah',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      for (int i = 0; i < recipe.steps.length; i++)
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            child: Text('${i + 1}'),
                          ),
                          title: Text(recipe.steps[i]),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}