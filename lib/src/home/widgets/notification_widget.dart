import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/widgets/login_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';

import '../../../common/services/storage.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Storage().getString('accessToken') == null) {
          loginBottomSheet(context);
        } else {
          context.push('/notification');
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          right: 12.w,
        ),
        child: CircleAvatar(
          backgroundColor: Kolors.kGrayLight.withOpacity(0.3),
          child: const Badge(
            label: Text('4'),
            child: Icon(
              Ionicons.notifications,
              color: Kolors.kPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
