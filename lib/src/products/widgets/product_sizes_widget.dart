import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/src/products/controllers/color_sizes_notifier.dart';
import 'package:fashion_app/src/products/controllers/product_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductSizesWidget extends StatelessWidget {
  const ProductSizesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorSizesNotifier>(
      builder: (context, controller, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            context.read<ProductNotifier>().product!.sizes.length,
            (i) {
              String size = context.read<ProductNotifier>().product!.sizes[i];
              return GestureDetector(
                onTap: () {
                  controller.setSizes(size);
                },
                child: Container(
                  height: 30.h,
                  width: 45.w,
                  decoration: BoxDecoration(
                    color: controller.sizes == size
                        ? Kolors.kPrimary
                        : Kolors.kGrayLight,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      size,
                      style: appStyle(
                        20,
                        Kolors.kWhite,
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
