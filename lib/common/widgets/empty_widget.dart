import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/resource.dart';
class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        R.ASSETS_IMAGES_EMPTY_PNG,
        height: ScreenUtil().screenHeight * 0.3,
      ),
    );
  }
}