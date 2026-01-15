import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final List<int> _expandedFaqs = [0];

  static const List<_FaqItem> _faqs = [
    _FaqItem(
      question: '如何拍摄更清晰的影像?',
      answer: '为了获得最佳的 AI 分析结果，请确保拍摄时光线充足，将手机与胶片保持平行，并避免屏幕反光。建议使用纯色背景。',
    ),
    _FaqItem(
      question: 'AI 分析需要多长时间?',
      answer: '通常情况下，AI分析会在上传后1-2分钟内完成。复杂的影像可能需要稍长时间。',
    ),
    _FaqItem(
      question: '我的医疗数据是否安全?',
      answer: '您的数据安全是我们的首要任务。所有数据均采用端到端加密存储，符合医疗数据保护标准。',
    ),
  ];

  @override
  void dispose() {
    _feedbackController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: _buildHeader(context),
              ),
              // Content
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Problem Description
                    _buildSectionLabel('问题描述', isRequired: true),
                    const SizedBox(height: 8),
                    _buildTextArea(),
                    const SizedBox(height: 24),
                    // Image Upload
                    _buildImageUploadSection(),
                    const SizedBox(height: 24),
                    // Contact Info
                    _buildSectionLabel('联系方式', isRequired: false),
                    const SizedBox(height: 8),
                    _buildContactInput(),
                    const SizedBox(height: 24),
                    // FAQ Section
                    const Text(
                      '常见问题 (FAQ)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ..._faqs.asMap().entries.map((entry) => 
                      _buildFaqCard(entry.key, entry.value)),
                    const SizedBox(height: 24),
                    // Disclaimer
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: const Text(
                        '注意：此反馈表格仅用于应用技术支持和功能建议。如遇紧急医疗情况，请立即联系医生或前往医院就诊。',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textTertiary,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
          // Submit Button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: const Border(
                  top: BorderSide(color: AppColors.border),
                ),
              ),
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: _submitFeedback,
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      '提交反馈',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.borderLight),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    CupertinoIcons.back,
                    size: 20,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            const Expanded(
              child: Text(
                '意见反馈与帮助',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(width: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label, {required bool isRequired}) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          if (isRequired)
            const Text(
              ' *',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.error,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextArea() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CupertinoTextField(
        controller: _feedbackController,
        placeholder: '请详细描述您遇到的问题或建议，以帮助我们改进产品...',
        placeholderStyle: const TextStyle(
          color: AppColors.textTertiary,
          fontSize: 14,
        ),
        padding: const EdgeInsets.all(16),
        decoration: null,
        minLines: 6,
        maxLines: 10,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 14,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildImageUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              '添加图片',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              '选填，最多3张',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            // Uploaded Image Preview
            _buildImagePreview(),
            const SizedBox(width: 12),
            // Upload Button 1
            _buildUploadButton(filled: true),
            const SizedBox(width: 12),
            // Upload Button 2
            _buildUploadButton(filled: false),
          ],
        ),
      ],
    );
  }

  Widget _buildImagePreview() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        image: const DecorationImage(
          image: NetworkImage(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAPlZl4BZM3V_AK7WnMcUeJz2eSboEpnGICrUO1Kq83Y3Y-QiUTZ8JLZna3XgwsOt1djdAQe-sxfrgx3FOdH5RwJMdJgu_2mhu3TQuLERHXw11hX6vDpJAKn5J8P6eBo22qrdbWbscUq56I1fPuyCzS9_wDMpQ8fZZGpZouW909N72uWKIIylp5YxQWum6Em6VofuTo0OYjcz8J6mYJZDpq1ZPVDVrpaNe0GpeLe-6t-YL4gmmqC7GItKAlEHRCnBUEjXiW0AA4xJw',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: const Color(0xFF000000).withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              CupertinoIcons.xmark,
              size: 14,
              color: CupertinoColors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadButton({required bool filled}) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      child: Center(
        child: Icon(
          filled ? CupertinoIcons.camera_fill : CupertinoIcons.add,
          size: 32,
          color: filled ? AppColors.primary : AppColors.textTertiary,
        ),
      ),
    );
  }

  Widget _buildContactInput() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Icon(
            CupertinoIcons.mail,
            size: 20,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: CupertinoTextField(
              controller: _contactController,
              placeholder: '请输入您的邮箱或手机号',
              placeholderStyle: const TextStyle(
                color: AppColors.textTertiary,
                fontSize: 14,
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: null,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  Widget _buildFaqCard(int index, _FaqItem item) {
    final isExpanded = _expandedFaqs.contains(index);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                if (isExpanded) {
                  _expandedFaqs.remove(index);
                } else {
                  _expandedFaqs.add(index);
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item.question,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isExpanded ? FontWeight.w600 : FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? CupertinoIcons.chevron_up
                        : CupertinoIcons.chevron_down,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                item.answer,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _submitFeedback() {
    // TODO: Implement feedback submission
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('提交成功'),
        content: const Text('感谢您的反馈！我们会尽快处理。'),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
              context.pop();
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}

class _FaqItem {
  final String question;
  final String answer;

  const _FaqItem({
    required this.question,
    required this.answer,
  });
}
