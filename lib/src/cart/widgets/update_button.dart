import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/src/cart/controllers/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UpdateButton extends StatelessWidget {
  final void Function()? onUpdate;

  const UpdateButton({
    super.key,
    this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onUpdate,
      onLongPress: () {
        context.read<CartNotifier>().clearSelected();
      },
      child: Container(
        width: 65.w,
        height: 18.h,
        decoration: BoxDecoration(
          color: Kolors.kPrimaryLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: ReusableText(
            text: 'Update',
            style: appStyle(
              11,
              Kolors.kWhite,
              FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
