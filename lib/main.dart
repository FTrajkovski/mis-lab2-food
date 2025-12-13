import 'package:flutter/material.dart';
import 'package:mis_lab2_201087/screens/register.dart';
import 'screens/categories_screen.dart';
import 'screens/meals_screen.dart';
import 'screens/meal_details_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    );

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
      initialRoute: "/",
      routes: {
        "/": (context) => const RegisterPage(),
        "/home": (context) => const CategoriesScreen(title: "Meal Categories"),
        "/details": (context) => const MealsScreen(),
        "/meal_details": (context) => const MealDetailsScreen(),
      },
    );
  }
}
