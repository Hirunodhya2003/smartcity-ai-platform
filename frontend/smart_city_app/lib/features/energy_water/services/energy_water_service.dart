import '../models/energy_issue_model.dart';

class EnergyWaterService {
  // TODO: replace mock data with real API call
  // GET /api/v1/issues?category=energy
  Future<List<EnergyIssue>> fetchEnergyIssues({
    String? search,
    String? status,
    String? priority,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final now = DateTime.now();
    final all = <EnergyIssue>[
      EnergyIssue(
        id: 1,
        title: 'Streetlight not working',
        description: 'Streetlight near the main junction is off since last night.',
        category: 'energy',
        status: 'reported',
        priority: 'medium',
        createdAt: now.subtract(const Duration(days: 1)),
        updatedAt: now,
        latitude: 7.2083,
        longitude: 79.8358,
        address: 'Main Street',
        city: 'Negombo',
      ),
      EnergyIssue(
        id: 2,
        title: 'Power outage in residential area',
        description: 'No electricity for the past 3 hours.',
        category: 'energy',
        status: 'in_progress',
        priority: 'high',
        createdAt: now.subtract(const Duration(hours: 5)),
        updatedAt: now,
        city: 'Negombo',
      ),
      EnergyIssue(
        id: 3,
        title: 'Damaged electric pole',
        description: 'Pole leaning dangerously after the storm.',
        category: 'energy',
        status: 'resolved',
        priority: 'high',
        createdAt: now.subtract(const Duration(days: 4)),
        updatedAt: now,
        city: 'Colombo',
      ),
    ];

    return all.where((i) {
      final matchSearch = search == null ||
          search.isEmpty ||
          i.title.toLowerCase().contains(search.toLowerCase());
      final matchStatus = status == null || i.status == status;
      final matchPriority = priority == null || i.priority == priority;
      return matchSearch && matchStatus && matchPriority;
    }).toList();
  }
}