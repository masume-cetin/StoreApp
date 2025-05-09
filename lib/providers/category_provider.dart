import 'package:flutter/material.dart';
import 'package:generic_services_package/generic_services_package.dart';
import '../models/categoryModels/category_model.dart';

class CategoryProvider with ChangeNotifier {
  final ApiService service = ApiService();
  final List<Category> _category = [];

  List<Category> get category => _category;

  void setCategory(List<Category> category) {
    _category.clear();
    _category.addAll(category);
    notifyListeners();
  }
  Category? getItemByName(String name) {
    try {
      return _category.firstWhere((item) => item.name == name);
    } catch (_) {
      return null;
    }
  }
}