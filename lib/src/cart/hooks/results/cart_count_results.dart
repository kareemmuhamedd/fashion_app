import 'dart:ui';

import 'package:fashion_app/src/cart/models/cart_count_model.dart';

class FetchCartCount{
  final CartCountModel count;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;
  FetchCartCount({
    required this.count,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}