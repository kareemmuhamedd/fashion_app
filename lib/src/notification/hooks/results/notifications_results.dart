import 'dart:ui';

import 'package:fashion_app/common/utils/enums.dart';
import 'package:fashion_app/src/cart/models/cart_count_model.dart';
import 'package:fashion_app/src/notification/models/notification_model.dart';

class FetchNotifications {
  final List<NotificationModel> notifications;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchNotifications({
    required this.notifications,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
