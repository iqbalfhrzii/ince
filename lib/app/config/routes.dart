import 'package:flutter/material.dart';
import '../../features/pantry/screens/pantry_screen.dart';
import '../../features/recipe/screens/recipe_list_screen.dart';
import '../../features/recipe/screens/recipe_detail_screen.dart';
import '../../app/data/models/recipe_model.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/screens/profile_screen.dart';

class AppRoutes {
  static const String loginRoute = '/';
  static const String registerRoute = '/register';
  static const String pantryRoute = '/pantry';
  static const String recipeListRoute = '/recipe-list';
  static const String recipeDetailRoute = '/recipe-detail';
  static const String profileRoute = '/profile';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case pantryRoute:
        final email = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => PantryScreen(email: email ?? 'guest'));
      case profileRoute:
        final email = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => ProfileScreen(email: email ?? 'guest'));
      case recipeListRoute:
        final args = settings.arguments as List<Recipe>?;
        return MaterialPageRoute(builder: (_) => RecipeListScreen(recipes: args ?? []));
      case recipeDetailRoute:
        final args = settings.arguments as Recipe?;
        if (args == null) return MaterialPageRoute(builder: (_) => const PantryScreen(email: 'guest'));
        return MaterialPageRoute(builder: (_) => RecipeDetailScreen(recipe: args));
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}