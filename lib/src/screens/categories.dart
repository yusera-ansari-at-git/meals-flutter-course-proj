import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/src/models/category.dart';
import 'package:meals/src/screens/meals.dart';
import 'package:meals/src/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  void _selectCategory(context, Category category) {
    final meals = dummyMeals
        .where((element) => element.categories.contains(category.id))
        .toList();
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return MealsScreen(title: category.title, meals: meals);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 10),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              }),
      ],
    );
  }
}
