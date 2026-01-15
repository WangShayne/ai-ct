import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/locale_provider.dart';
import 'widgets/settings_section.dart';
import 'widgets/settings_row.dart';
import 'widgets/user_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();
    
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          '个人中心',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: CupertinoColors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.borderLight, width: 1),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Info Card
              const UserCard(
                name: '李先生',
                memberDays: 365,
                userId: '8839201',
              ),
              const SizedBox(height: 24),
              
              // Section 1: Personal Profile
              SettingsSection(
                title: '个人资料',
                children: [
                  SettingsRow(
                    icon: CupertinoIcons.person_fill,
                    label: '基本信息',
                    onTap: () => context.push('/profile/edit'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Section 2: Preferences
              SettingsSection(
                title: '偏好设置',
                children: [
                  SettingsRow(
                    icon: CupertinoIcons.bell_fill,
                    label: '消息通知',
                    trailing: CupertinoSwitch(
                      value: _notificationsEnabled,
                      activeColor: AppColors.primary,
                      onChanged: (value) {
                        setState(() => _notificationsEnabled = value);
                      },
                    ),
                    onTap: () => context.push('/notifications'),
                  ),
                  SettingsRow(
                    icon: CupertinoIcons.trash_fill,
                    label: '清除缓存',
                    value: '24MB',
                    onTap: () => _showClearCacheDialog(context),
                  ),
                  SettingsRow(
                    icon: CupertinoIcons.globe,
                    label: '多语言切换',
                    value: localeProvider.locale.languageCode == 'zh' ? '简体中文' : 'English',
                    onTap: () => _showLanguageDialog(context, localeProvider),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Section 3: About & Support
              SettingsSection(
                title: '关于与支持',
                children: [
                  SettingsRow(
                    icon: CupertinoIcons.book_fill,
                    label: '使用指南',
                    onTap: () {},
                  ),
                  SettingsRow(
                    icon: CupertinoIcons.chat_bubble_text_fill,
                    label: '意见反馈',
                    onTap: () => context.push('/feedback'),
                  ),
                  SettingsRow(
                    icon: CupertinoIcons.info_circle_fill,
                    label: '关于我们',
                    onTap: () {},
                  ),
                  const SettingsRow(
                    icon: CupertinoIcons.arrow_up_circle_fill,
                    label: '版本号',
                    value: 'v1.0.2',
                    showChevron: false,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Logout Button
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => _showLogoutDialog(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
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
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        CupertinoIcons.square_arrow_right,
                        color: AppColors.error,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '退出登录',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 100), // Bottom padding for nav
            ],
          ),
        ),
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('清除缓存'),
        content: const Text('确定要清除本地缓存数据吗？'),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement cache clearing
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, LocaleProvider provider) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('选择语言'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              provider.setLocale(const Locale('zh'));
              Navigator.pop(context);
            },
            child: Text(
              '简体中文',
              style: TextStyle(
                color: provider.locale.languageCode == 'zh' 
                    ? AppColors.primary 
                    : AppColors.textPrimary,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              provider.setLocale(const Locale('en'));
              Navigator.pop(context);
            },
            child: Text(
              'English',
              style: TextStyle(
                color: provider.locale.languageCode == 'en' 
                    ? AppColors.primary 
                    : AppColors.textPrimary,
              ),
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('退出登录'),
        content: const Text('确定要退出当前账号吗？'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement logout
            },
            child: const Text('退出'),
          ),
        ],
      ),
    );
  }
}
