import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/utils/kstrings.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/src/products/widgets/explore_products.dart';
import 'package:fashion_app/src/wishlist/widgets/wishlist_widget.dart';
import 'package:flutter/material.dart';

import '../../../common/services/storage.dart';
import '../../auth/views/login_screen.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    if (accessToken == null) {
      return const LoginScreen();
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: ReusableText(
          text: AppText.kWishlist,
          style: appStyle(
            16,
            Kolors.kPrimary,
            FontWeight.bold,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: WishlistWidget(),
      ),
    );
  }
}
