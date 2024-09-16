import 'dart:ui';

import 'package:fashion_app/src/cart/models/cart_count_model.dart';
import 'package:fashion_app/src/cart/models/cart_model.dart';

class FetchCart{
  final List<CartModel> cart;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;
  FetchCart({
    required this.cart,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}