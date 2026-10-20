import 'package:flutter/material.dart';
import 'package:smart_city_app/core/theme/app_colors.dart';

import '../models/notification_model.dart';

class NotificationDetailsScreen extends StatefulWidget {
  final NotificationModel notification;
  final VoidCallback onMarkAsRead;

  const NotificationDetailsScreen({
    super.key,
    required this.notification,
    required this.onMarkAsRead,
  });

  @override
  State<NotificationDetailsScreen> createState() =>
      _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
  late bool _isRead;

  @override
  void initState() {
    super.initState();
    _isRead = widget.notification.isRead;
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.notification;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Notification details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Chip(label: Text('Preview • Sample data')),
                const SizedBox(height: 16),
                Text(
                  item.title,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${item.category} • ${item.date}',
                  style: const TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 20),
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      item.message,
                      style: const TextStyle(
                        color: AppColors.text,
                        fontSize: 16,
                        height: 1.6,
                      ),
                    ),
                  ),
                ),
                if (item.reportId != null) ...[
                  const SizedBox(height: 20),
                  Text(
                    'Related report: ${item.reportId}',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _isRead
                      ? null
                      : () {
                          widget.onMarkAsRead();
                          setState(() => _isRead = true);
                        },
                  icon: Icon(_isRead ? Icons.done_all : Icons.mark_email_read),
                  label: Text(_isRead ? 'Already read' : 'Mark as read'),
                ),
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back to notifications'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
