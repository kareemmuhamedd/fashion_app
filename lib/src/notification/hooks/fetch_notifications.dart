import 'package:fashion_app/common/utils/environment.dart';
import 'package:fashion_app/src/notification/controllers/notification_notifier.dart';
import 'package:fashion_app/src/notification/hooks/results/notifications_results.dart';
import 'package:fashion_app/src/notification/models/notification_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../common/services/storage.dart';

FetchNotifications fetchNotifications(BuildContext context) {
  final notifications = useState<List<NotificationModel>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);
  final accessToken = Storage().getString('accessToken');
  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/notifications/me/');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );
      if (response.statusCode == 200) {
        notifications.value = notificationModelFromJson(response.body);
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return;
  }, const []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  context.read<NotificationNotifier>().setRefetchNotifications(refetch);

  return FetchNotifications(
    notifications: notifications.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
