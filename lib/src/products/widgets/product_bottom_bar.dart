import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ProductBottomBar extends StatelessWidget {
  final String price;
  final void Function()? onPressed;

  const ProductBottomBar({
    super.key,
    required this.price,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68.h,
      color: Kolors.kWhite.withOpacity(0.6),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 12.w, 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60.h,
              width: 120.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: ReusableText(
                      text: 'Total Price',
                      style: appStyle(
                        14,
                        Kolors.kGray,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                  ReusableText(
                    text: '\$ $price',
                    style: appStyle(
                      16,
                      Kolors.kDark,
                      FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Kolors.kPrimary),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    FontAwesome.shopping_bag,
                    size: 16,
                    color: Kolors.kWhite,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  ReusableText(
                    text: 'Add To Cart',
                    style: appStyle(
                      14,
                      Kolors.kWhite,
                      FontWeight.bold,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
