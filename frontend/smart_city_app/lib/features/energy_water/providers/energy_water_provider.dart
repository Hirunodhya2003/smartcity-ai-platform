import 'package:flutter/foundation.dart';

import '../models/energy_issue_model.dart';
import '../services/energy_water_service.dart';

class EnergyWaterProvider extends ChangeNotifier {
  final EnergyWaterService _service;

  EnergyWaterProvider({EnergyWaterService? service})
      : _service = service ?? EnergyWaterService();

  List<EnergyIssue> _energyIssues = [];
  bool _isLoading = false;
  String? _error;

  String _search = '';
  String? _status;
  String? _priority;

  List<EnergyIssue> get energyIssues => _energyIssues;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get status => _status;
  String? get priority => _priority;

  Future<void> loadEnergyIssues() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _energyIssues = await _service.fetchEnergyIssues(
        search: _search,
        status: _status,
        priority: _priority,
      );
    } catch (e) {
      _error = 'Failed to load energy reports';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSearch(String value) {
    _search = value;
    loadEnergyIssues();
  }

  void setStatus(String? value) {
    _status = value;
    loadEnergyIssues();
  }

  void setPriority(String? value) {
    _priority = value;
    loadEnergyIssues();
  }
}