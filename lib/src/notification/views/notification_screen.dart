import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/utils/kstrings.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/back_button.dart';
import 'package:fashion_app/common/widgets/empty_screen_widget.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/src/notification/controllers/notification_notifier.dart';
import 'package:fashion_app/src/notification/hooks/fetch_notifications.dart';
import 'package:fashion_app/src/notification/views/notification_shimmer.dart';
import 'package:fashion_app/src/notification/widgets/notification_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends HookWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchNotifications(context);
    final notifications = result.notifications;
    final isLoading = result.isLoading;

    if (isLoading) {
      return const NotificationShimmer();
    }
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
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
      body: notifications.isEmpty
          ? const EmptyScreenWidget()
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return NotificationTile(
                  notification: notifications[index],
                  index: index,
                  onUpdate: () {
                    context
                        .read<NotificationNotifier>()
                        .setOrderId(notifications[index].orderId);
                  },
                );
              },
            ),
    );
  }
}
