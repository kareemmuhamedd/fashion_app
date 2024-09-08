import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/const/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../controllers/color_sizes_notifier.dart';
import '../controllers/product_notifier.dart';

class ColorSelectionWidget extends StatelessWidget {
  const ColorSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorSizesNotifier>(
      builder: (context, controller, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            context.read<ProductNotifier>().product!.colors.length,
            (index) {
              String color =
                  context.read<ProductNotifier>().product!.colors[index];
              return GestureDetector(
                onTap: () {
                  controller.setColor(color);
                },
                child: Container(
                  padding: EdgeInsets.only(right: 20.w, left: 20.w),
                  margin: EdgeInsets.only(right: 20.w),
                  decoration: BoxDecoration(
                    borderRadius: kRadiusAll,
                    color: color == controller.color
                        ? Kolors.kPrimary
                        : Kolors.kGrayLight,
                  ),
                  child: ReusableText(
                    text: color,
                    style: appStyle(
                      12,
                      Kolors.kWhite,
                      FontWeight.normal,
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
