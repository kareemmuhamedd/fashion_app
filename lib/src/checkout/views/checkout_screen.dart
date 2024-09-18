import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/utils/kstrings.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/back_button.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/src/addresses/widgets/address_block.dart';
import 'package:fashion_app/src/cart/controllers/cart_notifier.dart';
import 'package:fashion_app/src/checkout/widgets/checkout_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../addresses/hooks/fetch_default.dart';

class CheckoutScreen extends HookWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchDefaultAddress();
    final address = result.address;
    final isLoading = result.isLoading;
    return Scaffold(
      appBar: AppBar(
        title: ReusableText(
          text: AppText.kCheckout,
          style: appStyle(
            16,
            Kolors.kPrimary,
            FontWeight.bold,
          ),
        ),
        leading: AppBackButton(
          onTap: () {
            // clean the address and payment details
            context.pop();
          },
        ),
      ),
      body: Consumer<CartNotifier>(
        builder: (context, cartNotifier, child) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            children: [
              isLoading
                  ? const SizedBox.shrink()
                  : AddressBlock(address: address),
              SizedBox(height: 10.h),
              SizedBox(
                height: ScreenUtil().screenHeight * 0.5,
                child: Column(
                  children: List.generate(
                    cartNotifier.selectedCartItems.length,
                    (index) {
                      return CheckoutTile(
                        cart: cartNotifier.selectedCartItems[index],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
