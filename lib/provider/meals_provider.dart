import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';

// class MealsProvider extends ChangeNotifier {
//   List _items = [];
//   List get items {
//     return [..._items];
//   }
// }
final mealsProvider = Provider(
  (ref) => (dummyMeals),
);
