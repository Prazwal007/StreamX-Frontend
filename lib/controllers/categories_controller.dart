import 'package:flutter/material.dart';

class CategoryController extends ChangeNotifier {
  String activeCategory = 'all';
  bool isSidebarCollapsed = false;

  void setActiveCategory(String category) {
    activeCategory = category;
    notifyListeners();
  }

  void toggleSidebar() {
    isSidebarCollapsed = !isSidebarCollapsed;
    notifyListeners();
  }

  void setSidebarCollapsed(bool value) {
    isSidebarCollapsed = value;
    notifyListeners();
  }
}
