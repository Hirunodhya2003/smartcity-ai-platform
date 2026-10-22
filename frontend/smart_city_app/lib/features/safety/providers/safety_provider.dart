import 'package:flutter/foundation.dart';

import '../models/air_quality_model.dart';
import '../services/safety_service.dart';

const _connectionMessage =
    'Could not load data. Check your connection and that the server is running.';

class SafetyProvider extends ChangeNotifier {
  final SafetyService _service;

  SafetyProvider({SafetyService? service})
      : _service = service ?? SafetyService();

  bool _disposed = false;

  // ---- Air quality: latest readings ----
  List<AirQualityReading> readings = [];
  String? _selectedArea;
  bool isLoadingAir = false;
  String? airError;

  AirQualityReading? get selectedReading {
    for (final r in readings) {
      if (r.area == _selectedArea) return r;
    }
    return readings.isEmpty ? null : readings.first;
  }

  // ---- Air quality: history ----
  AirQualityHistory? history;
  String historyPeriod = 'daily';
  bool isLoadingHistory = false;
  String? historyError;
  int _historyRequest = 0;

  Future<void> loadAirQuality() async {
    isLoadingAir = true;
    airError = null;
    _notify();

    try {
      readings = await _service.fetchLatestAirQuality();
      final stillExists = readings.any((r) => r.area == _selectedArea);
      if (!stillExists) {
        _selectedArea = readings.isEmpty ? null : readings.first.area;
      }
    } on ApiException catch (e) {
      airError = e.message;
    } catch (_) {
      airError = _connectionMessage;
    }

    isLoadingAir = false;
    _notify();
  }

  void selectArea(String area) {
    if (area == _selectedArea) return;
    _selectedArea = area;
    history = null;
    historyError = null;
    _notify();
  }

  Future<void> loadHistory({String? period}) async {
    final area = selectedReading?.area;
    if (period != null) historyPeriod = period;

    if (area == null) {
      historyError = 'Select an area first.';
      _notify();
      return;
    }

    final request = ++_historyRequest; // ignore out-of-order responses
    isLoadingHistory = true;
    historyError = null;
    _notify();

    try {
      final result = await _service.fetchAirQualityHistory(area, historyPeriod);
      if (request != _historyRequest) return;
      history = result;
    } on ApiException catch (e) {
      if (request != _historyRequest) return;
      history = null;
      historyError = e.message;
    } catch (_) {
      if (request != _historyRequest) return;
      history = null;
      historyError = _connectionMessage;
    }

    isLoadingHistory = false;
    _notify();
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
