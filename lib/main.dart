import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'app/config/theme.dart';
import 'app/config/routes.dart';
import 'app/data/providers/recipe_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  // Membuka database pantry
  await Hive.openBox<String>('pantryBox');
  
  // MEMBUKA DATABASE BARU UNTUK AKUN
  await Hive.openBox<String>('userBox');

  // Menambahkan data user default jika box baru dibuat
  final userBox = Hive.box<String>('userBox');
  if (userBox.isEmpty) {
    userBox.put('user@mail.com', 'password123');
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => RecipeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chef Genius',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.loginRoute,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}