import '../core/api/api_client.dart';
import '../core/api/api_config.dart';
import '../models/record.dart';

/// Service for file upload API operations
class UploadService {
  final ApiClient _client;

  UploadService(this._client);

  /// Upload a medical image for AI analysis
  Future<Record?> uploadImage({
    required String filePath,
    String? title,
    String? type,
  }) async {
    final response = await _client.uploadFile<Map<String, dynamic>>(
      '${ApiConfig.upload}/image',
      filePath: filePath,
      fieldName: 'file',
      fields: {
        if (title != null) 'title': title,
        if (type != null) 'type': type,
      },
      fromJsonT: (data) => data as Map<String, dynamic>,
    );

    if (response.data != null) {
      return Record.fromJson(response.data!);
    }
    return null;
  }

  /// Upload multiple images
  Future<List<Record>> uploadMultipleImages(List<String> filePaths) async {
    final results = <Record>[];

    for (final path in filePaths) {
      final record = await uploadImage(filePath: path);
      if (record != null) {
        results.add(record);
      }
    }

    return results;
  }

  /// Check upload progress (if using chunked upload)
  Future<double> getUploadProgress(String uploadId) async {
    final response = await _client.get<Map<String, dynamic>>(
      '${ApiConfig.upload}/progress/$uploadId',
      fromJsonT: (data) => data as Map<String, dynamic>,
    );

    if (response.data != null) {
      return (response.data!['progress'] as num?)?.toDouble() ?? 0.0;
    }
    return 0.0;
  }

  /// Cancel an upload in progress
  Future<bool> cancelUpload(String uploadId) async {
    final response = await _client.delete('${ApiConfig.upload}/$uploadId');
    return response.success;
  }
}
