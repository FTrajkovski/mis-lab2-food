import 'package:flutter/material.dart';
import 'package:mis_lab2_201087/services/favorites_manager.dart';
import '../models/meal.dart';

class MealCard extends StatefulWidget {
  final Meal meal;
  const MealCard({super.key, required this.meal});

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  @override
  Widget build(BuildContext context) {
    final isFav = FavoritesManager.isFavorite(widget.meal);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/meal_details",
          arguments: widget.meal.id,
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.blue.shade300, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  widget.meal.thumbnail,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        FavoritesManager.toggleFavorite(widget.meal);
                      });
                    },
                  ),
                ),
              ],
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.meal.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}