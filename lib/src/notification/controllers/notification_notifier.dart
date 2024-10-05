import 'package:flutter/cupertino.dart';

import '../../../common/services/storage.dart';
import '../../../common/utils/environment.dart';
import 'package:http/http.dart' as http;

class NotificationNotifier extends ChangeNotifier {
  Function? refetchNotificationsCount;

  void setRefetchNotificationsCount(Function refetch) {
    refetchNotificationsCount = refetch;
  }

  Function? refetchNotifications;

  void setRefetchNotifications(Function refetch) {
    refetchNotifications = refetch;
  }

  int _orderId = 0;

  int get orderId => _orderId;

  void setOrderId(int orderId) {
    _orderId = orderId;
    markAsRead(orderId);
    notifyListeners();
  }

  void markAsRead(int notificationId) async {
    final accessToken = Storage().getString('accessToken');
    try {
      Uri url =
          Uri.parse('${Environment.appBaseUrl}/api/notifications/update/?id=$notificationId');
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        refetchNotifications!();
        refetchNotificationsCount!();
      }

    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
