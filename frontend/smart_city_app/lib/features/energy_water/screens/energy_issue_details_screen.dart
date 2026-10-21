
import 'package:flutter/material.dart';
import 'package:smart_city_app/core/theme/app_colors.dart';

import '../models/energy_issue_model.dart';

class EnergyIssueDetailsScreen extends StatelessWidget {
  final EnergyIssue issue;

  const EnergyIssueDetailsScreen({
    super.key,
    required this.issue,
  });

  static const _timeline = [
    'reported',
    'in_progress',
    'resolved',
  ];

  Color _priorityColor() {
    switch (issue.priority.toLowerCase()) {
      case 'high':
        return AppColors.error;
      case 'medium':
        return AppColors.warning;
      default:
        return AppColors.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = _timeline.indexOf(issue.status);

    final location = [
      issue.address,
      issue.city,
    ].whereType<String>().where((value) => value.trim().isNotEmpty).join(', ');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Energy Report Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              issue.title,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _chip(
                  issue.status.replaceAll('_', ' '),
                  AppColors.primary,
                ),
                _chip(
                  '${issue.priority} priority',
                  _priorityColor(),
                ),
              ],
            ),
            const SizedBox(height: 20),

            _section(
              'Description',
              Text(
                issue.description,
                style: const TextStyle(
                  color: AppColors.text,
                  fontSize: 15,
                ),
              ),
            ),

            _section(
              'Location',
              Text(
                location.isEmpty ? 'Location not available' : location,
                style: const TextStyle(
                  color: AppColors.text,
                  fontSize: 15,
                ),
              ),
            ),

            _section(
              'Status Timeline',
              Column(
                children: [
                  for (var i = 0; i < _timeline.length; i++)
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        i <= currentStep && currentStep >= 0
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: i <= currentStep && currentStep >= 0
                            ? AppColors.success
                            : AppColors.muted,
                      ),
                      title: Text(
                        _timeline[i].replaceAll('_', ' '),
                        style: TextStyle(
                          color: i <= currentStep && currentStep >= 0
                              ? AppColors.text
                              : AppColors.muted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            _section(
              'Reported',
              Text(
                issue.createdAt.toLocal().toString().substring(0, 16),
                style: const TextStyle(
                  color: AppColors.muted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _section(String title, Widget child) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              child,
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
