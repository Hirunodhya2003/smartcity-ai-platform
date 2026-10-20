import 'package:flutter/foundation.dart';

import '../models/notification_model.dart';
import '../services/notification_service.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationProvider() {
    _notifications = NotificationService().getSampleNotifications();
  }

  late List<NotificationModel> _notifications;

  List<NotificationModel> get notifications =>
      List.unmodifiable(_notifications);

  int get unreadCount => _notifications.where((item) => !item.isRead).length;

  void markAsRead(String id) {
    final index = _notifications.indexWhere((item) => item.id == id);

    if (index == -1 || _notifications[index].isRead) return;

    _notifications[index] = _notifications[index].markAsRead();
    notifyListeners();
  }

  void markAllAsRead() {
    if (unreadCount == 0) return;

    _notifications = _notifications.map((item) => item.markAsRead()).toList();

    notifyListeners();
  }
}
