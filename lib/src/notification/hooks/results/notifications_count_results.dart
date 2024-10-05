import 'dart:ui';
import 'package:fashion_app/src/notification/models/notification_count_model.dart';

class FetchNotificationCount {
  final NotificationCountModel count;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchNotificationCount({
    required this.count,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
