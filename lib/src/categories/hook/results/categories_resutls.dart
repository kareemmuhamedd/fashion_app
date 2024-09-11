import 'dart:ui';

import 'package:fashion_app/src/categories/model/categories_model.dart';

class FetchCategories{
  final List<Categories> categories;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;
  FetchCategories({
    required this.categories,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}