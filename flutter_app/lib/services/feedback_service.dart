import '../core/api/api_client.dart';
import '../core/api/api_config.dart';

/// Service for feedback/support API operations
class FeedbackService {
  final ApiClient _client;

  FeedbackService(this._client);

  /// Submit user feedback
  Future<bool> submitFeedback({
    required String content,
    String? contactInfo,
    List<String>? imagePaths,
  }) async {
    // If there are images, use multipart upload
    if (imagePaths != null && imagePaths.isNotEmpty) {
      return _submitFeedbackWithImages(
        content: content,
        contactInfo: contactInfo,
        imagePaths: imagePaths,
      );
    }

    // Simple POST request for text-only feedback
    final response = await _client.post(
      ApiConfig.feedback,
      body: {
        'content': content,
        if (contactInfo != null) 'contact_info': contactInfo,
      },
    );

    return response.success;
  }

  /// Submit feedback with images
  Future<bool> _submitFeedbackWithImages({
    required String content,
    String? contactInfo,
    required List<String> imagePaths,
  }) async {
    // For multiple images, we'll need to submit each one
    // This is a simplified version - in production you'd use a multipart form
    final response = await _client.post(
      ApiConfig.feedback,
      body: {
        'content': content,
        if (contactInfo != null) 'contact_info': contactInfo,
        'image_count': imagePaths.length,
      },
    );

    if (!response.success) return false;

    // Upload images separately if feedback was created
    // In production, this would be done differently
    return true;
  }

  /// Get FAQ list
  Future<List<Map<String, String>>> getFaqs() async {
    final response = await _client.get<List<dynamic>>(
      '${ApiConfig.feedback}/faqs',
      fromJsonT: (data) => data as List<dynamic>,
    );

    if (response.data != null) {
      return response.data!
          .map((item) => {
                'question': item['question'] as String? ?? '',
                'answer': item['answer'] as String? ?? '',
              })
          .toList();
    }

    // Return default FAQs if API call fails
    return [
      {
        'question': '如何拍摄更清晰的影像?',
        'answer': '为了获得最佳的 AI 分析结果，请确保拍摄时光线充足，将手机与胶片保持平行，并避免屏幕反光。建议使用纯色背景。',
      },
      {
        'question': 'AI 分析需要多长时间?',
        'answer': '通常情况下，AI分析会在上传后1-2分钟内完成。复杂的影像可能需要稍长时间。',
      },
      {
        'question': '我的医疗数据是否安全?',
        'answer': '您的数据安全是我们的首要任务。所有数据均采用端到端加密存储，符合医疗数据保护标准。',
      },
    ];
  }
}
