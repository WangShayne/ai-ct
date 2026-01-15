import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int _selectedTab = 0;

  static const List<String> _tabs = ['报告提醒', '系统消息', '健康科普'];

  static final List<_NotificationItem> _todayNotifications = [
    _NotificationItem(
      title: '您的肺部CT分析报告已生成',
      body: '智能分析已完成，发现结节风险较低。点击查看详细影像分析结果及医生建议。',
      time: '10:30',
      icon: CupertinoIcons.doc_text_fill,
      iconColor: AppColors.primary,
      iconBgColor: AppColors.primary.withOpacity(0.1),
      isUnread: true,
    ),
    _NotificationItem(
      title: '如何预防冬季呼吸道疾病',
      body: '冬季流感高发期，专家建议做好这5点防护措施，守护家人健康。',
      time: '09:15',
      icon: CupertinoIcons.heart_fill,
      iconColor: AppColors.success,
      iconBgColor: AppColors.success.withOpacity(0.1),
      isUnread: true,
    ),
  ];

  static final List<_NotificationItem> _yesterdayNotifications = [
    _NotificationItem(
      title: '版本更新提醒 v2.1',
      body: '修复了已知Bug，优化了CT影像上传速度，提升了AI分析准确率。',
      time: '昨天',
      icon: CupertinoIcons.arrow_up_circle_fill,
      iconColor: AppColors.textSecondary,
      iconBgColor: AppColors.background,
      isUnread: false,
    ),
    _NotificationItem(
      title: 'X光胸片上传成功',
      body: '您的影像资料已上传至云端档案，AI正在进行初步筛查。',
      time: '昨天',
      icon: CupertinoIcons.doc_fill,
      iconColor: AppColors.primary,
      iconBgColor: AppColors.primary.withOpacity(0.1),
      isUnread: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context),
            // Tabs
            _buildTabs(),
            // Content
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // Today Section
                  _buildSectionHeader('今日'),
                  ..._todayNotifications.map((n) => _buildNotificationTile(n)),
                  // Yesterday Section
                  _buildSectionHeader('昨天'),
                  ..._yesterdayNotifications.map((n) => _buildNotificationTile(n)),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: const SizedBox(
              width: 48,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  CupertinoIcons.back,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
          const Text(
            '消息通知',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(
            width: 48,
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  CupertinoIcons.checkmark_alt_circle,
                  size: 22,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final isSelected = _selectedTab == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? AppColors.primary : AppColors.borderLight,
                      width: isSelected ? 3 : 1,
                    ),
                  ),
                ),
                child: Text(
                  _tabs[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? AppColors.primary : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildNotificationTile(_NotificationItem item) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: item.iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                item.icon,
                size: 20,
                color: item.iconColor,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: item.isUnread ? FontWeight.w600 : FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (item.isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(left: 8),
                        decoration: const BoxDecoration(
                          color: AppColors.error,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item.body,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Time
          Text(
            item.time,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationItem {
  final String title;
  final String body;
  final String time;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final bool isUnread;

  _NotificationItem({
    required this.title,
    required this.body,
    required this.time,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.isUnread,
  });
}
