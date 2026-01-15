import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class ReportScreen extends StatelessWidget {
  final String id;

  const ReportScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverToBoxAdapter(
              child: _buildAppBar(context),
            ),
            // Content
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Image Viewer
                  _buildImageViewer(),
                  const SizedBox(height: 24),
                  // Risk Assessment
                  _buildRiskAssessment(),
                  const SizedBox(height: 24),
                  // Findings
                  _buildFindings(),
                  const SizedBox(height: 24),
                  // Action Buttons
                  _buildActionButtons(context),
                  const SizedBox(height: 16),
                  // Disclaimer
                  _buildDisclaimer(),
                  const SizedBox(height: 32),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.borderLight),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: const SizedBox(
              width: 40,
              height: 40,
              child: Center(
                child: Icon(
                  CupertinoIcons.back,
                  size: 24,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          const Text(
            '影像分析报告',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(
            width: 40,
            height: 40,
            child: Center(
              child: Icon(
                CupertinoIcons.ellipsis,
                size: 24,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageViewer() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Container(
                    color: const Color(0xFF1A1A2E),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuDsy1d0N3urq7FCUHs26yAs9NyBgh2keht5t_2uo4FxgvmrY_2G6_MIl5uen0pDLU7LLJRZqi5sX2z0WD8jIJvCZX11Ny9YD-qlvSQKCEGXDA2q05sm-RldROKU3vOLO4wFLyrbZmYNsHRZQPtLq4nUSfTZbNBUyejB8mweqCtlN_flLE3IKx0Zs_9L3JFd5s6ODNjaYLfol0iPTAv6OD-Ltw5Yybt3oLJTKsLCukNvvfun_yvsI3bEw4n0pIHkQC-RYh9tif0ugaM',
                          fit: BoxFit.cover,
                          opacity: const AlwaysStoppedAnimation(0.9),
                        ),
                        // AI Detection Box
                        Positioned(
                          top: 80,
                          right: 100,
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primary.withOpacity(0.8),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.3),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: const Text(
                                  '98%',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: CupertinoColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // View Tag
                        Positioned(
                          top: 16,
                          left: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF000000).withOpacity(0.6),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              '轴向视图',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: CupertinoColors.white,
                              ),
                            ),
                          ),
                        ),
                        // Controls
                        Positioned(
                          bottom: 16,
                          right: 16,
                          child: Row(
                            children: [
                              _buildImageControl(CupertinoIcons.layers),
                              const SizedBox(width: 8),
                              _buildImageControl(CupertinoIcons.zoom_in),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Info
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.borderLight)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '影像编号: #$id',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Text(
                      '2023年10月24日 • 14:30',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  '胸部CT扫描 • 序列 4',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageControl(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: const Color(0xFF000000).withOpacity(0.5),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          size: 18,
          color: CupertinoColors.white,
        ),
      ),
    );
  }

  Widget _buildRiskAssessment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '健康风险提示',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
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
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '风险指数',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '需重点关注',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: const [
                      Text(
                        '85',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        '/100',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Progress Labels
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('健康', style: TextStyle(fontSize: 12, color: AppColors.textTertiary, fontWeight: FontWeight.w500)),
                  Text('关注', style: TextStyle(fontSize: 12, color: AppColors.textTertiary, fontWeight: FontWeight.w500)),
                  Text('高风险', style: TextStyle(fontSize: 12, color: AppColors.textTertiary, fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(height: 8),
              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                  height: 12,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(color: AppColors.primary.withOpacity(0.3)),
                      ),
                      Expanded(
                        child: Container(color: AppColors.primary.withOpacity(0.6)),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(color: AppColors.primary),
                            Positioned(
                              right: 12,
                              top: 0,
                              bottom: 0,
                              child: Container(
                                width: 4,
                                color: CupertinoColors.white.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Recommendation
              const Text(
                'AI建议：发现一些值得关注的影像特征，建议您尽快携带影像资料咨询专科医生进行详细评估。',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFindings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              '影像发现',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              '查看详情',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Finding 1
        _buildFindingCard(
          title: '肺部结节',
          icon: CupertinoIcons.circle_fill,
          confidence: 98,
          isHighPriority: true,
          description: '在右肺上部发现一个约6毫米的小结节。建议医生结合临床情况判断。',
          tags: ['右肺上叶', '实性', '6mm'],
        ),
        const SizedBox(height: 12),
        // Finding 2
        _buildFindingCard(
          title: '少量积液',
          icon: CupertinoIcons.drop_fill,
          confidence: 85,
          isHighPriority: false,
          description: '左侧胸腔底部发现少量液体积聚，可能是身体的自然反应，建议咨询医生。',
          tags: [],
        ),
      ],
    );
  }

  Widget _buildFindingCard({
    required String title,
    required IconData icon,
    required int confidence,
    required bool isHighPriority,
    required String description,
    required List<String> tags,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
        border: Border(
          left: BorderSide(
            color: isHighPriority ? AppColors.primary : AppColors.primary.withOpacity(0.4),
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 20,
                    color: isHighPriority ? AppColors.primary : AppColors.primary.withOpacity(0.6),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isHighPriority ? AppColors.primary.withOpacity(0.1) : AppColors.background,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '置信度 $confidence%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isHighPriority ? AppColors.primary : AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          if (tags.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: tags.map((tag) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              )).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    CupertinoIcons.doc_text,
                    size: 20,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '下载PDF报告',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            child: Container(
              height: 48,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    CupertinoIcons.arrow_down_to_line,
                    size: 20,
                    color: CupertinoColors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '保存到手机',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDisclaimer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        '温馨提示：AI结果仅供参考，请以医生诊断为准',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          color: AppColors.warning,
        ),
      ),
    );
  }
}
