import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/widgets/login_bottom_sheet.dart';
import 'package:fashion_app/src/notification/hooks/fetch_notifications_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';

import '../../../common/services/storage.dart';

class NotificationWidget extends HookWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchNotificationCount(context);
    final count = result.count.unreadCount;
    final isLoading = result.isLoading;
    return GestureDetector(
      onTap: () {
        if (Storage().getString('accessToken') == null) {
          loginBottomSheet(context);
        } else {
          context.push('/notifications');
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          right: 12.w,
        ),
        child: CircleAvatar(
          backgroundColor: Kolors.kGrayLight.withOpacity(0.3),
          child: Badge(
            label: Text(isLoading ? '0' : count.toString()),
            child: const Icon(
              Ionicons.notifications,
              color: Kolors.kPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
