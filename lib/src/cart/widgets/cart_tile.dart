import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/const/constants.dart';
import 'package:fashion_app/src/cart/models/cart_model.dart';
import 'package:fashion_app/src/cart/widgets/cart_counter.dart';
import 'package:fashion_app/src/cart/widgets/update_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

import '../controllers/cart_notifier.dart';

class CartTile extends StatelessWidget {
  final CartModel cart;
  final void Function()? onDelete;
  final void Function()? onUpdate;

  const CartTile({
    super.key,
    required this.cart,
    this.onDelete,
    this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartNotifier>(
      builder: (context, cartNotifier, child) {
        return GestureDetector(
          onTap: () {
            cartNotifier.selectOrDeselect(cart.id, cart);
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Container(
              width: ScreenUtil().screenWidth,
              height: 90.h,
              decoration: BoxDecoration(
                color: !cartNotifier.selectedCartItemsId.contains(cart.id)
                    ? Kolors.kWhite
                    : Kolors.kPrimaryLight.withOpacity(0.2),
                borderRadius: kRadiusAll,
              ),
              child: SizedBox(
                height: 85.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Kolors.kWhite,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: kRadiusAll,
                                child: SizedBox(
                                  width: 76.w,
                                  height: double.infinity,
                                  child: CachedNetworkImage(
                                    imageUrl: cart.product.imageUrls.first,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                child: GestureDetector(
                                  onTap: onDelete,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Icon(
                                      AntDesign.delete,
                                      size: 14,
                                      color: Kolors.kWhite,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReusableText(
                              text: cart.product.title,
                              style: appStyle(
                                12,
                                Kolors.kDark,
                                FontWeight.normal,
                              ),
                            ),
                            ReusableText(
                              text:
                                  'Size: ${cart.size}   ||   Color: ${cart.color}'
                                      .toUpperCase(),
                              style: appStyle(
                                12,
                                Kolors.kGray,
                                FontWeight.normal,
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().screenWidth * 0.5,
                              child: Text(
                                cart.product.description,
                                maxLines: 2,
                                textAlign: TextAlign.justify,
                                style: appStyle(
                                  10,
                                  Kolors.kGray,
                                  FontWeight.normal,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 6.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          cartNotifier.selectedCart != null &&
                                  cartNotifier.selectedCart == cart.id
                              ? const CartCounter()
                              : GestureDetector(
                                  onTap: () {
                                    // push the current count
                                    // push cart id as well
                                  },
                                  onDoubleTap: () {
                                    cartNotifier.setSelectedCounter(
                                      cart.id,
                                      cart.quantity,
                                    );
                                  },
                                  child: Container(
                                    width: 40.w,
                                    height: 20.h,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Kolors.kPrimary,
                                        width: 0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: ReusableText(
                                      text: '* ${cart.quantity}',
                                      style: appStyle(
                                        12,
                                        Kolors.kPrimary,
                                        FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 6.h,
                          ),
                          cartNotifier.selectedCart != null &&
                                  cartNotifier.selectedCart == cart.id
                              ? UpdateButton(
                                  onUpdate: onUpdate,
                                )
                              : Padding(
                                  padding: EdgeInsets.only(right: 6.0.w),
                                  child: ReusableText(
                                    text:
                                        '\$ ${(cart.quantity * cart.product.price).toStringAsFixed(2)}',
                                    style: appStyle(
                                      12,
                                      Kolors.kPrimary,
                                      FontWeight.w600,
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
