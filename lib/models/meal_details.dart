class MealDetails {
  final String id;
  final String name;
  final String thumbnail;
  final String instructions;
  final List<String> ingredients;
  final String? youtubeLink;

  MealDetails({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.instructions,
    required this.ingredients,
    this.youtubeLink
  });

  factory MealDetails.fromJson(Map<String, dynamic> json) {
    final ingredients = <String>[];

    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add("$ingredient - ${measure ?? ''}".trim());
      }
    }

    return MealDetails(
      id: json['idMeal'],
      name: json['strMeal'],
      thumbnail: json['strMealThumb'],
      instructions: json['strInstructions'] ?? '',
      ingredients: ingredients,
      youtubeLink: json['strYoutube']
    );
  }
}
