import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../const/constants.dart';
import '../utils/kcolors.dart';
import '../utils/kstrings.dart';
import 'app_style.dart';
import 'custom_button.dart';

Future<dynamic> loginBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 200,
        decoration: BoxDecoration(borderRadius: kRadiusTop),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: ReusableText(
                text: AppText.kLogin,
                style: appStyle(
                  16,
                  Kolors.kPrimary,
                  FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Divider(
              color: Kolors.kGrayLight,
              thickness: 0.5.h,
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: ReusableText(
                text: AppText.kLoginText,
                style: appStyle(
                  14,
                  Kolors.kGray,
                  FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GradientBtn(
                text: "Proceed to Login",
                onTap: () {
                  context.go("/login");
                },
                btnHieght: 35.h,
                radius: 16,
                btnWidth: ScreenUtil().screenWidth,
              ),
            )
          ],
        ),
      );
    },
  );
}
