import '../models/meal.dart';

class FavoritesManager {
  static final List<Meal> _favorites = [];

  static List<Meal> get favorites => _favorites;

  static bool isFavorite(Meal meal) =>
      _favorites.any((m) => m.id == meal.id);

  static void toggleFavorite(Meal meal) {
    if (isFavorite(meal)) {
      _favorites.removeWhere((m) => m.id == meal.id);
    } else {
      _favorites.add(meal);
    }
  }
}