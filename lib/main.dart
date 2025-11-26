import 'package:flutter/material.dart';
import 'screens/categories_screen.dart';
import 'screens/meals_screen.dart';
import 'screens/meal_details_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      initialRoute: "/home",
      routes: {
        "/home": (context) => const CategoriesScreen(title: "Meal Categories"),
        "/details": (context) => const MealsScreen(),
        "/meal_details": (context) => const MealDetailsScreen(),
      },
    );
  }
}
