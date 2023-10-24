import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/src/models/category.dart';
import 'package:meals/src/models/meal.dart';
import 'package:meals/src/screens/meals.dart';
import 'package:meals/src/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});
  final List<Meal> availableMeals;
  @override
  State<CategoriesScreen> createState() {
    return _CategoriesScreenState();
  }
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      lowerBound: 0, //default
      upperBound: 1, //default
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _selectCategory(context, Category category) {
    final meals = widget.availableMeals.where((element) {
      return element.categories.contains(category.id);
    }).toList();
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return MealsScreen(
        title: category.title,
        meals: meals,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: Offset(0, 0.3), //1 means 100%
          end: Offset(0, 0),
        ).animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.easeInOut),
        ),
        child: child,
      ),
      // builder: (context, child) => Padding(
      //   padding: EdgeInsets.only(top: 100 - _animationController.value * 100),
      //   child: child,
      // ),
    );
  }
}
