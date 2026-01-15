import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../models/record.dart';
import 'widgets/record_card.dart';
import 'widgets/action_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final List<Record> _recentRecords = [
    const Record(
      id: '48291',
      title: '胸部 CT 检测报告',
      date: '10 分钟前',
      time: '',
      type: 'AI 深度分析 • 肺部影像',
      thumbnail: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCE1pPA9AwYpUrLPUpMzfFjA1eG4bG1BmA5_69qnqlfvtV_JWHGYpQXRYGabIqfZE1jwDSU-X33hQwVnNinMOa7MbGypbAvUjcU7t6oRkZof6v-o0BlkIGos8VZFdwRViYLPSYfl5NVt8-XxFeUFRNUzHsNNHUvGE4qCF33vmcy-MZM7aaNVQq4uiqprNXoqAOTV7hnkOGNUTSD-lSsJ9RSd_mipxncaNgSy8J3QUrKI0IOYLGVf5YlGUiUWdP8o90AwfjKctlbSqU',
      status: RecordStatus.completed,
      statusLabel: '已生成',
    ),
    const Record(
      id: 'processing',
      title: '头部 CT 影像',
      date: '2 小时前',
      time: '',
      type: '正在进行 AI 运算...',
      thumbnail: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC6_vhFufvz-BYhyqnY381hxddcGyr7uo7b9Y1JfGbYHSfDHwOIDbxIYVjsqV215zrMDDcTxzqBdaJjUNoqnGYdAKdw_2j_pF1lup5ZylQ2JWS8Tm8X3c-NskP-26KWbgT3ElZVBXelDp4WPlSnkElhh2tJCZIhP5uc6hSra6Sh72h_mHgyg5mpQNqACa6b3KW0sj7ge106LUnL0TEap3AJcefCXkmn2aCGHEX9aLWsdMJotT5U8IVOLymT-EqxPMwSuw_ULnumzOw',
      status: RecordStatus.processing,
      statusLabel: '分析中',
    ),
    const Record(
      id: 'normal',
      title: '腹部常规检查',
      date: '昨天',
      time: '',
      type: '无明显异常发现',
      thumbnail: null,
      status: RecordStatus.normal,
      statusLabel: '已生成',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: _buildHeader(context),
            ),
            // Main Content
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Hero Section
                  _buildHeroSection(context),
                  const SizedBox(height: 24),
                  // Upload Card
                  _buildUploadCard(context),
                  const SizedBox(height: 24),
                  // Recent Records Header
                  _buildRecentRecordsHeader(context),
                  const SizedBox(height: 12),
                  // Recent Records List
                  ..._recentRecords.map((record) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: RecordCard(
                      record: record,
                      onTap: record.status != RecordStatus.processing
                          ? () => context.push('/report/${record.id}')
                          : null,
                    ),
                  )),
                  const SizedBox(height: 80), // Bottom padding for nav
                ]),
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
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.9),
        border: const Border(
          bottom: BorderSide(color: AppColors.borderLight, width: 1),
        ),
      ),
      child: Row(
        children: [
          // User Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary.withOpacity(0.2),
                width: 2,
              ),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuC33gh9r-8-pxjOXB1uN9xTy7RcOrZgQavPv2LY5DJj6PCE--fJMiO34VxV7Rv4X2IPI8fiZoUoUkV9lRsTtsCNnCuYSNT4BQHADLv6GxSbseV07zo-fBYT8LuIvtEpQWJ0DEZjjfCYF2I_e0arMsJUngaD0uJ4eP6-tZd8iJA8PsWeYMIRbtlua9rpkWoIjxVYV26_-Y9LjGyDw-pw4Y37pkfMfam_DPw7w0wpbBLHZH6P1nRnBr-XFUVvTzoZQW3e0RoXE0JdgEs',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '个人中心',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  '张伟',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          // Notification Button
          GestureDetector(
            onTap: () => context.push('/notifications'),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    CupertinoIcons.bell,
                    size: 22,
                    color: AppColors.textSecondary,
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.surface, width: 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          '您好，张伟',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 4),
        Text(
          '上传您的影像资料，获取AI健康解析。',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildUploadCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          // Main Action Button
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            child: Container(
              width: double.infinity,
              height: 56,
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
                    CupertinoIcons.sparkles,
                    color: CupertinoColors.white,
                    size: 22,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '开始AI分析',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: CupertinoColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Divider
          Row(
            children: [
              Expanded(child: Container(height: 1, color: AppColors.borderLight)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '其他方式',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textTertiary,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Expanded(child: Container(height: 1, color: AppColors.borderLight)),
            ],
          ),
          const SizedBox(height: 16),
          // Secondary Actions
          Row(
            children: [
              Expanded(
                child: ActionButton(
                  icon: CupertinoIcons.camera,
                  label: '拍照上传',
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ActionButton(
                  icon: CupertinoIcons.photo_on_rectangle,
                  label: '从相册选择',
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentRecordsHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '最近记录',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        GestureDetector(
          onTap: () => context.go('/files'),
          child: const Text(
            '查看全部',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
