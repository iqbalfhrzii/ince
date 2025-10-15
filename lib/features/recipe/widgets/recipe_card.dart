import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../app/data/models/recipe_model.dart';
import '../screens/recipe_detail_screen.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final scorePercentage = (recipe.score * 100).toStringAsFixed(0);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(recipe: recipe),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: recipe.imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[200],
                    child: const Center(child: Icon(Icons.image, color: Colors.grey)),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[200],
                    child: const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      recipe.description,
                      style: TextStyle(color: Colors.grey[600], fontSize: 13.0),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8.0),
                    Wrap(
                      spacing: 6.0,
                      runSpacing: 4.0,
                      children: [
                        _buildInfoChip(Icons.timer_outlined, recipe.duration),
                        _buildInfoChip(Icons.restaurant_menu_outlined, recipe.servings),
                        _buildInfoChip(
                          Icons.check_circle_outline,
                          '$scorePercentage% Cocok',
                          iconColor: Colors.green,
                          backgroundColor: Colors.green.shade100,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, {Color? iconColor, Color? backgroundColor}) {
    // --- PERBAIKAN DARI 'Transform' MENJADI 'Transform.scale' ---
    return Transform.scale(
      scale: 0.9,
      child: Chip(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0),
        labelPadding: const EdgeInsets.only(left: 2.0, right: 4.0),
        avatar: Icon(icon, color: iconColor ?? Colors.deepOrange, size: 16),
        label: Text(label, style: const TextStyle(fontSize: 11)),
        backgroundColor: backgroundColor ?? Colors.deepOrange.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.grey.shade200),
        ),
      ),
    );
  }
}