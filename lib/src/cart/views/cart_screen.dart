import 'package:fashion_app/src/cart/controllers/cart_notifier.dart';
import 'package:fashion_app/src/cart/widgets/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../common/services/storage.dart';
import '../../../common/utils/kcolors.dart';
import '../../../common/utils/kstrings.dart';
import '../../../common/widgets/app_style.dart';
import '../../../common/widgets/reusable_text.dart';
import '../../../common/widgets/shimmers/list_shimmer.dart';
import '../../auth/views/login_screen.dart';
import '../hooks/fetch_cart.dart';

class CartScreen extends HookWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final results = fetchCart();
    final carts = results.cart;
    final isLoading = results.isLoading;
    final refetch = results.refetch;
    final error = results.error;
    if (accessToken == null) {
      return const LoginScreen();
    }
    if (isLoading) {
      return const Scaffold(
        body: ListShimmer(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: ReusableText(
          text: AppText.kCart,
          style: appStyle(
            15,
            Kolors.kPrimary,
            FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        children: List.generate(
          carts.length,
          (index) {
            final cart = carts[index];
            return CartTile(
              cart: cart,
              onUpdate: () {
                context.read<CartNotifier>().updateCart(cart.id, refetch);
              },
              onDelete: () {
                context.read<CartNotifier>().deleteCart(cart.id, refetch);
              },
            );
          },
        ),
      ),
    );
  }
}
