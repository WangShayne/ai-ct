import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../models/record.dart';

class FilesScreen extends StatelessWidget {
  const FilesScreen({super.key});

  static final List<_RecordSection> _sections = [
    _RecordSection(
      month: '2023年10月',
      count: 2,
      items: [
        const Record(
          id: '1',
          title: '胸部CT扫描',
          date: '2023-10-15 14:30',
          time: '14:30',
          type: '胸部',
          thumbnail: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBVdwBoyCPV_JDQvKinPkxoDz4xvyokALWlaZphlVjMDuvrT40g_6Mku6K1XVz6Iv_PP4g78AYKaZLzy7H7LkPN-SVqJDL1StSQNcXU7LwzF9Hyg9vNti2qhkp0Vt7cVxEJNS7h8j6mET5pbkwI-A_Zzky6AZJrfnFj-BbJ5qf0nxSPUvPr8CWS7R8tyrrZCMNCzmaTmVtNiM20XqgAeVuRstRe-55X_gyncW8p-LsPFa95DXxE64ilNrYDMsoDtztEEGYdN1-tbXo',
          status: RecordStatus.attention,
          statusLabel: '建议随访',
        ),
        const Record(
          id: '2',
          title: '左手X光片',
          date: '2023-10-02 09:15',
          time: '09:15',
          type: '四肢',
          thumbnail: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDuqBd7_uI3bbB5MGDnhLwCtN8ZygO_3WRFjK4v70VQ1oZpWuD6k0guqJi-Iwpv93-YeQcDcExmBwvXD2mT4t3zWzZEzRMiOdB8gDVWk0jj9kuGOAEmlKL3G-z4ShKY4VEOGSjGKVJyXHn9pjl6YdwJb-OG0VkyLIe51rIsvyUd4kGWineks2uAKagBt6gNFi555dUCDrnXPXRHBjQpUFi_m8UFhz4RuKtPpEkvXzCIKQeqoULkd3QMLcrDvytljr_93Vb5WIn6RqA',
          status: RecordStatus.normal,
          statusLabel: '未见异常',
        ),
      ],
    ),
    _RecordSection(
      month: '2023年08月',
      count: 1,
      items: [
        const Record(
          id: '3',
          title: '头部MRI检查',
          date: '2023-08-20 11:00',
          time: '11:00',
          type: '头部',
          thumbnail: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBB47UCeq6FYo1ztE9eL3ZM4nVNiowUdKrjMyOZz-ayRzHy4OYPTPhb3Vq_x561VNvbAuGkStil42y1Sku4qpWFU1rJSMZNR29K4TTo4T9r9bDbPvuIaltSwk9QsiMsXH4itsK8O6zyVRS8lb8eQ-B2rYA32DUZMmhRDmgjHWbxrZ3odRqOCIn904_F2LTQvsYyRuH7dXDP3_ygxRlxcUv3yKDY00tRLtzrKBdR2FgbNHATw8Pw2XjSE-IG9kmtiwAQ55W3lqE4V8A',
          status: RecordStatus.normal,
          statusLabel: '未见异常',
        ),
      ],
    ),
    _RecordSection(
      month: '2022年12月',
      count: 1,
      items: [
        const Record(
          id: '4',
          title: '腹部超声波',
          date: '2022-12-05 08:45',
          time: '08:45',
          type: '腹部',
          thumbnail: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAEXvyZy52-Xfs6pXL2cVwBFlfgExHvSNhiKTOx4ZIUBhH93UeR6nhbdVNzc5CFW1Tf9kP9LnC__su1i4K2qCG6MLrNzOP_lSZQeG9hQnhJTl4TJREOAYvP8JKhTCYBb40AE5AH0muDBXQPdXH1JLx8eEt-Ng55uN3wWDrwjUUvJlX2O3nHYeU5OIEYQJNKwmVoXOWTPE5FGysHwPkHT90QYGKc2y4NSL6Ct0koMB0oftCkinWJFlYPYg7lQYdgoi3R6n0jnodjYjY',
          status: RecordStatus.processing,
          statusLabel: 'AI分析中',
        ),
      ],
    ),
  ];

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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final section = _sections[index];
                      return _buildSection(context, section);
                    },
                    childCount: _sections.length,
                  ),
                ),
              ),
              // Bottom padding
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          ),
          // Floating Action Button
          Positioned(
            bottom: 96,
            right: 20,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    CupertinoIcons.photo_on_rectangle,
                    color: CupertinoColors.white,
                    size: 28,
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
      color: AppColors.surface,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
                const Text(
                  '我的健康档案',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 40),
              ],
            ),
            const SizedBox(height: 16),
            // Search Bar
            Container(
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  SizedBox(width: 12),
                  Icon(
                    CupertinoIcons.search,
                    size: 20,
                    color: AppColors.textTertiary,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: CupertinoTextField(
                      placeholder: '搜索历史影像报告',
                      placeholderStyle: TextStyle(
                        color: AppColors.textTertiary,
                        fontSize: 14,
                      ),
                      padding: EdgeInsets.zero,
                      decoration: null,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, _RecordSection section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                section.month,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '${section.count} 份报告',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
        // Records
        ...section.items.map((record) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildRecordTile(context, record),
        )),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildRecordTile(BuildContext context, Record record) {
    return GestureDetector(
      onTap: () => context.push('/report/${record.id}'),
      child: Container(
        padding: const EdgeInsets.all(12),
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
        child: Row(
          children: [
            // Thumbnail
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
                image: record.thumbnail != null
                    ? DecorationImage(
                        image: NetworkImage(record.thumbnail!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 16),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    record.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    record.date,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildStatusBadge(record),
                ],
              ),
            ),
            // Chevron
            const Icon(
              CupertinoIcons.chevron_right,
              size: 18,
              color: AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(Record record) {
    IconData icon;
    Color color;
    Color bgColor;
    Color borderColor;

    switch (record.status) {
      case RecordStatus.attention:
        icon = CupertinoIcons.exclamationmark_circle_fill;
        color = AppColors.warning;
        bgColor = AppColors.warning.withOpacity(0.08);
        borderColor = AppColors.warning.withOpacity(0.2);
        break;
      case RecordStatus.normal:
      case RecordStatus.completed:
        icon = CupertinoIcons.checkmark_circle_fill;
        color = AppColors.success;
        bgColor = AppColors.success.withOpacity(0.08);
        borderColor = AppColors.success.withOpacity(0.2);
        break;
      case RecordStatus.processing:
        icon = CupertinoIcons.time;
        color = AppColors.textSecondary;
        bgColor = AppColors.background;
        borderColor = AppColors.border;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            record.statusLabel,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecordSection {
  final String month;
  final int count;
  final List<Record> items;

  _RecordSection({
    required this.month,
    required this.count,
    required this.items,
  });
}
