import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/utils/kstrings.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/back_button.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/const/constants.dart';
import 'package:fashion_app/src/addresses/widgets/address_block.dart';
import 'package:fashion_app/src/cart/controllers/cart_notifier.dart';
import 'package:fashion_app/src/checkout/models/create_checkout_model.dart';
import 'package:fashion_app/src/checkout/views/payment_screen.dart';
import 'package:fashion_app/src/checkout/widgets/checkout_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/services/storage.dart';
import '../../addresses/controllers/address_notifier.dart';
import '../../addresses/hooks/fetch_default.dart';

class CheckoutScreen extends HookWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? accessToken = Storage().getString('accessToken');
    final result = fetchDefaultAddress();
    final address = result.address;
    final isLoading = result.isLoading;
    return context
            .watch<CartNotifier>()
            .paymentUrl
            .contains('https://checkout.stripe.com')
        ? const PaymentWebView()
        : Scaffold(
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
                  // clean the address
                  context.read<AddressNotifier>().clearAddress();

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
            bottomNavigationBar: Consumer<CartNotifier>(
              builder: (context, cartNotifier, child) {
                return GestureDetector(
                  onTap: () {
                    if (address == null) {
                      context.push('/addresses');
                    } else {
                      List<CartItem> checkoutItems = [];
                      for (var item in cartNotifier.selectedCartItems) {
                        CartItem data = CartItem(
                          name: item.product.title,
                          size: item.size,
                          color: item.color,
                          id: item.product.id,
                          price: item.product.price.roundToDouble(),
                          cartQuantity: item.quantity,
                        );
                        checkoutItems.add(data);
                      }
                      CreateCheckoutModel data = CreateCheckoutModel(
                        accesstoken: accessToken.toString(),
                        fcm: '',
                        totalAmount: cartNotifier.totalPrice,
                        address: context.read<AddressNotifier>().address == null
                            ? address.id
                            : context.read<AddressNotifier>().address!.id,
                        cartItems: checkoutItems,
                      );
                      String c = createCheckoutModelToJson(data);
                      cartNotifier.createCheckout(c);
                    }
                    // create checkout
                  },
                  child: Container(
                    height: 80.h,
                    width: ScreenUtil().screenWidth,
                    decoration: BoxDecoration(
                      color: Kolors.kPrimaryLight,
                      borderRadius: kRadiusTop,
                    ),
                    child: Center(
                      child: ReusableText(
                        text: address == null
                            ? 'Please an address'
                            : 'Continue to Payment',
                        style: appStyle(
                          16,
                          Kolors.kWhite,
                          FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
