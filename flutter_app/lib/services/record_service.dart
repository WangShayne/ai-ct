import '../core/api/api_client.dart';
import '../core/api/api_config.dart';
import '../models/record.dart';

/// Service for medical record API operations
class RecordService {
  final ApiClient _client;

  RecordService(this._client);

  /// Get all records for current user
  Future<List<Record>> getRecords({
    int page = 1,
    int limit = 20,
    String? status,
  }) async {
    final queryParams = <String, String>{
      'page': page.toString(),
      'limit': limit.toString(),
    };
    if (status != null) {
      queryParams['status'] = status;
    }

    final response = await _client.get<List<dynamic>>(
      ApiConfig.records,
      queryParams: queryParams,
      fromJsonT: (data) => data as List<dynamic>,
    );

    if (response.data != null) {
      return response.data!
          .map((json) => Record.fromJson(json as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  /// Get a single record by ID
  Future<Record?> getRecord(String id) async {
    final response = await _client.get<Map<String, dynamic>>(
      '${ApiConfig.records}/$id',
      fromJsonT: (data) => data as Map<String, dynamic>,
    );

    if (response.data != null) {
      return Record.fromJson(response.data!);
    }
    return null;
  }

  /// Get recent records (limited count)
  Future<List<Record>> getRecentRecords({int limit = 5}) async {
    return getRecords(page: 1, limit: limit);
  }

  /// Get records grouped by month
  Future<Map<String, List<Record>>> getRecordsGroupedByMonth() async {
    final records = await getRecords(limit: 100);
    final grouped = <String, List<Record>>{};

    for (final record in records) {
      // Extract month from date (format: "YYYY-MM-DD HH:MM")
      final parts = record.date.split(' ');
      if (parts.isNotEmpty) {
        final datePart = parts[0];
        final dateSegments = datePart.split('-');
        if (dateSegments.length >= 2) {
          final year = dateSegments[0];
          final month = dateSegments[1];
          final monthKey = '$year年${month}月';
          
          grouped.putIfAbsent(monthKey, () => []);
          grouped[monthKey]!.add(record);
        }
      }
    }

    return grouped;
  }

  /// Delete a record
  Future<bool> deleteRecord(String id) async {
    final response = await _client.delete('${ApiConfig.records}/$id');
    return response.success;
  }
}
