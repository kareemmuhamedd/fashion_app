import 'package:fashion_app/common/widgets/shimmers/list_shimmer.dart';
import 'package:flutter/material.dart';

import '../../../common/utils/kcolors.dart';
import '../../../common/utils/kstrings.dart';
import '../../../common/widgets/app_style.dart';
import '../../../common/widgets/reusable_text.dart';

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ReusableText(
          text: AppText.kNotifications,
          style: appStyle(
            16,
            Kolors.kPrimary,
            FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Kolors.kWhite,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: ListShimmer(),
        ),
      ),
    );
  }
}
