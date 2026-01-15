import 'package:flutter/foundation.dart';
import '../core/api/api_client.dart';
import '../models/record.dart';
import '../services/record_service.dart';

/// Provider for managing medical records state
class RecordProvider extends ChangeNotifier {
  final RecordService _service;
  
  List<Record> _records = [];
  List<Record> _recentRecords = [];
  Map<String, List<Record>> _groupedRecords = {};
  bool _isLoading = false;
  String? _error;
  
  RecordProvider(ApiClient client) : _service = RecordService(client);
  
  // Getters
  List<Record> get records => _records;
  List<Record> get recentRecords => _recentRecords;
  Map<String, List<Record>> get groupedRecords => _groupedRecords;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  /// Load all records
  Future<void> loadRecords() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _records = await _service.getRecords();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Load recent records (for home screen)
  Future<void> loadRecentRecords({int limit = 5}) async {
    try {
      _recentRecords = await _service.getRecentRecords(limit: limit);
      notifyListeners();
    } catch (e) {
      // Silently fail for recent records
      debugPrint('Error loading recent records: $e');
    }
  }
  
  /// Load records grouped by month
  Future<void> loadGroupedRecords() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _groupedRecords = await _service.getRecordsGroupedByMonth();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  
  /// Get a single record by ID
  Future<Record?> getRecord(String id) async {
    // Check cache first
    final cached = _records.where((r) => r.id == id).toList();
    if (cached.isNotEmpty) {
      return cached.first;
    }
    
    // Fetch from API
    return _service.getRecord(id);
  }
  
  /// Delete a record
  Future<bool> deleteRecord(String id) async {
    try {
      final success = await _service.deleteRecord(id);
      if (success) {
        _records.removeWhere((r) => r.id == id);
        _recentRecords.removeWhere((r) => r.id == id);
        notifyListeners();
      }
      return success;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
  
  /// Add a new record (after upload)
  void addRecord(Record record) {
    _records.insert(0, record);
    if (_recentRecords.length >= 5) {
      _recentRecords.removeLast();
    }
    _recentRecords.insert(0, record);
    notifyListeners();
  }
  
  /// Clear all cached data
  void clear() {
    _records = [];
    _recentRecords = [];
    _groupedRecords = {};
    _error = null;
    notifyListeners();
  }
}
