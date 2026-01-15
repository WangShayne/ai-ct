# Flutter Migration Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Migrate MediScan AI from React/TypeScript to Flutter with Python/FastAPI backend.

**Architecture:** Feature-first Flutter structure with Cupertino UI, Provider state management, go_router navigation. Backend uses FastAPI with SQLModel ORM and PostgreSQL.

**Tech Stack:** Flutter 3.x, Dart, Provider, go_router, flutter_localizations, Python 3.11+, FastAPI, SQLModel, PostgreSQL, Alembic

---

## Phase 1: Project Setup

### Task 1: Initialize Flutter Project

**Files:**
- Create: `flutter_app/` (Flutter project)
- Create: `flutter_app/pubspec.yaml`

**Step 1: Create Flutter project**

Run:
```bash
cd /home/shayne/work/ai-ct/.worktrees/flutter-migration
flutter create --org com.mediscan --project-name mediscan_ai flutter_app
```

Expected: Flutter project created with default structure

**Step 2: Verify project builds**

Run:
```bash
cd flutter_app && flutter pub get && flutter analyze
```

Expected: No analysis issues

**Step 3: Commit**

```bash
git add flutter_app
git commit -m "feat: initialize Flutter project structure"
```

---

### Task 2: Add Dependencies

**Files:**
- Modify: `flutter_app/pubspec.yaml`

**Step 1: Update pubspec.yaml with dependencies**

Replace content after `dependencies:` section:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: ^0.19.0
  provider: ^6.1.1
  go_router: ^14.0.0
  cupertino_icons: ^1.0.8
  http: ^1.2.0
  cached_network_image: ^3.3.1
  image_picker: ^1.0.7

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0
  build_runner: ^2.4.8
  intl_utils: ^2.8.7

flutter:
  generate: true
  uses-material-design: true
```

**Step 2: Install dependencies**

Run:
```bash
cd flutter_app && flutter pub get
```

Expected: All dependencies resolved

**Step 3: Commit**

```bash
git add flutter_app/pubspec.yaml flutter_app/pubspec.lock
git commit -m "feat: add core dependencies (provider, go_router, intl)"
```

---

### Task 3: Configure Localization

**Files:**
- Create: `flutter_app/l10n.yaml`
- Create: `flutter_app/lib/l10n/app_en.arb`
- Create: `flutter_app/lib/l10n/app_zh.arb`

**Step 1: Create l10n.yaml**

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
```

**Step 2: Create app_en.arb**

```json
{
  "@@locale": "en",
  "appName": "MediScan AI",
  "home": "Home",
  "files": "Files",
  "settings": "Settings",
  "save": "Save",
  "cancel": "Cancel",
  "viewAll": "View All",
  "greeting": "Hello, {name}",
  "@greeting": {
    "placeholders": {
      "name": {"type": "String"}
    }
  },
  "uploadHint": "Upload your scans for AI health analysis.",
  "startAnalysis": "Start AI Analysis",
  "takePhoto": "Take Photo",
  "chooseAlbum": "Choose from Album",
  "recentRecords": "Recent Records",
  "statusCompleted": "Completed",
  "statusProcessing": "Processing",
  "statusNormal": "Normal",
  "statusAttention": "Follow-up",
  "notifications": "Notifications",
  "feedback": "Feedback",
  "profile": "Profile",
  "editProfile": "Edit Profile",
  "basicInfo": "Basic Info",
  "healthOverview": "Health Overview",
  "medicalHistory": "Medical History",
  "saveAndUpdate": "Save & Update",
  "logout": "Logout",
  "myHealthFiles": "My Health Files",
  "searchRecords": "Search records...",
  "reports": "reports",
  "reportDetails": "Report Details",
  "riskLevel": "Risk Level",
  "needsAttention": "Needs Attention",
  "findings": "Findings",
  "downloadPdf": "Download PDF",
  "saveToPhone": "Save to Phone",
  "disclaimer": "Note: AI results are for reference only. Please consult a doctor.",
  "reportAlerts": "Report Alerts",
  "systemMessages": "System Messages",
  "healthTips": "Health Tips",
  "today": "Today",
  "yesterday": "Yesterday",
  "markAllRead": "Mark All Read",
  "feedbackTitle": "Feedback & Help",
  "issueDescription": "Issue Description",
  "addImages": "Add Images",
  "optional3Images": "Optional, max 3 images",
  "contactInfo": "Contact Info",
  "emailOrPhone": "Email or phone number",
  "faq": "FAQ",
  "submit": "Submit",
  "clearCache": "Clear Cache",
  "language": "Language",
  "userGuide": "User Guide",
  "aboutUs": "About Us",
  "version": "Version"
}
```

**Step 3: Create app_zh.arb**

```json
{
  "@@locale": "zh",
  "appName": "MediScan AI",
  "home": "首页",
  "files": "档案",
  "settings": "设置",
  "save": "保存",
  "cancel": "取消",
  "viewAll": "查看全部",
  "greeting": "您好，{name}",
  "uploadHint": "上传您的影像资料，获取AI健康解析。",
  "startAnalysis": "开始AI分析",
  "takePhoto": "拍照上传",
  "chooseAlbum": "从相册选择",
  "recentRecords": "最近记录",
  "statusCompleted": "已生成",
  "statusProcessing": "分析中",
  "statusNormal": "未见异常",
  "statusAttention": "建议随访",
  "notifications": "消息通知",
  "feedback": "意见反馈",
  "profile": "个人中心",
  "editProfile": "编辑个人资料",
  "basicInfo": "基本信息",
  "healthOverview": "健康概况",
  "medicalHistory": "影像分析相关背景",
  "saveAndUpdate": "保存并更新",
  "logout": "退出登录",
  "myHealthFiles": "我的健康档案",
  "searchRecords": "搜索历史影像报告",
  "reports": "份报告",
  "reportDetails": "影像分析报告",
  "riskLevel": "风险指数",
  "needsAttention": "需重点关注",
  "findings": "影像发现",
  "downloadPdf": "下载PDF报告",
  "saveToPhone": "保存到手机",
  "disclaimer": "温馨提示：AI结果仅供参考，请以医生诊断为准",
  "reportAlerts": "报告提醒",
  "systemMessages": "系统消息",
  "healthTips": "健康科普",
  "today": "今日",
  "yesterday": "昨天",
  "markAllRead": "全部已读",
  "feedbackTitle": "意见反馈与帮助",
  "issueDescription": "问题描述",
  "addImages": "添加图片",
  "optional3Images": "选填，最多3张",
  "contactInfo": "联系方式",
  "emailOrPhone": "请输入您的邮箱或手机号",
  "faq": "常见问题",
  "submit": "提交反馈",
  "clearCache": "清除缓存",
  "language": "多语言切换",
  "userGuide": "使用指南",
  "aboutUs": "关于我们",
  "version": "版本号"
}
```

**Step 4: Generate localization files**

Run:
```bash
cd flutter_app && flutter gen-l10n
```

Expected: Generated `lib/l10n/app_localizations.dart`

**Step 5: Commit**

```bash
git add flutter_app/l10n.yaml flutter_app/lib/l10n/
git commit -m "feat: configure i18n with Chinese and English"
```

---

### Task 4: Create Theme System

**Files:**
- Create: `flutter_app/lib/core/theme/app_theme.dart`
- Create: `flutter_app/lib/core/theme/app_colors.dart`

**Step 1: Create app_colors.dart**

```dart
import 'package:flutter/cupertino.dart';

class AppColors {
  // Primary
  static const Color primary = Color(0xFF137FEC);
  static const Color primaryDark = Color(0xFF0B66C3);
  
  // Background
  static const Color background = Color(0xFFF6F7F8);
  static const Color surface = Color(0xFFFFFFFF);
  
  // Text
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);
  
  // Status
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFD97706);
  static const Color error = Color(0xFFEF4444);
  
  // Borders
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderLight = Color(0xFFF1F5F9);
}
```

**Step 2: Create app_theme.dart**

```dart
import 'package:flutter/cupertino.dart';
import 'app_colors.dart';

class AppTheme {
  static CupertinoThemeData get theme => const CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    barBackgroundColor: AppColors.surface,
    textTheme: CupertinoTextThemeData(
      primaryColor: AppColors.textPrimary,
      textStyle: TextStyle(
        fontFamily: '.SF Pro Text',
        color: AppColors.textPrimary,
      ),
    ),
  );
  
  // Shadows
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: CupertinoColors.black.withOpacity(0.04),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];
  
  static List<BoxShadow> get floatShadow => [
    BoxShadow(
      color: AppColors.primary.withOpacity(0.3),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];
  
  // Border Radius
  static BorderRadius get cardRadius => BorderRadius.circular(12);
  static BorderRadius get buttonRadius => BorderRadius.circular(12);
  static BorderRadius get inputRadius => BorderRadius.circular(12);
}
```

**Step 3: Commit**

```bash
git add flutter_app/lib/core/theme/
git commit -m "feat: add theme system with colors and shadows"
```

---

### Task 5: Create Data Models

**Files:**
- Create: `flutter_app/lib/models/record.dart`
- Create: `flutter_app/lib/models/notification.dart`
- Create: `flutter_app/lib/models/user_profile.dart`

**Step 1: Create record.dart**

```dart
enum RecordStatus { completed, processing, attention, normal }

class Record {
  final String id;
  final String title;
  final String date;
  final String time;
  final String type;
  final String? thumbnail;
  final RecordStatus status;
  final String statusLabel;
  
  const Record({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.type,
    this.thumbnail,
    required this.status,
    required this.statusLabel,
  });
  
  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      id: json['id'] as String,
      title: json['title'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      type: json['type'] as String,
      thumbnail: json['thumbnail'] as String?,
      status: RecordStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => RecordStatus.normal,
      ),
      statusLabel: json['status_label'] as String,
    );
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'date': date,
    'time': time,
    'type': type,
    'thumbnail': thumbnail,
    'status': status.name,
    'status_label': statusLabel,
  };
}
```

**Step 2: Create notification.dart**

```dart
enum NotificationType { report, system, health }

class AppNotification {
  final int id;
  final String title;
  final String description;
  final String time;
  final NotificationType type;
  final bool read;
  
  const AppNotification({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.type,
    required this.read,
  });
  
  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      time: json['time'] as String,
      type: NotificationType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => NotificationType.system,
      ),
      read: json['read'] as bool,
    );
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'time': time,
    'type': type.name,
    'read': read,
  };
}
```

**Step 3: Create user_profile.dart**

```dart
class UserProfile {
  final String name;
  final String id;
  final int joinDays;
  final String? avatar;
  final String? gender;
  final String? birthday;
  final String? phone;
  final int? height;
  final int? weight;
  final String? bloodType;
  
  const UserProfile({
    required this.name,
    required this.id,
    required this.joinDays,
    this.avatar,
    this.gender,
    this.birthday,
    this.phone,
    this.height,
    this.weight,
    this.bloodType,
  });
  
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] as String,
      id: json['id'] as String,
      joinDays: json['join_days'] as int,
      avatar: json['avatar'] as String?,
      gender: json['gender'] as String?,
      birthday: json['birthday'] as String?,
      phone: json['phone'] as String?,
      height: json['height'] as int?,
      weight: json['weight'] as int?,
      bloodType: json['blood_type'] as String?,
    );
  }
  
  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'join_days': joinDays,
    'avatar': avatar,
    'gender': gender,
    'birthday': birthday,
    'phone': phone,
    'height': height,
    'weight': weight,
    'blood_type': bloodType,
  };
}
```

**Step 4: Commit**

```bash
git add flutter_app/lib/models/
git commit -m "feat: add data models (Record, Notification, UserProfile)"
```

---

### Task 6: Create Locale Provider

**Files:**
- Create: `flutter_app/lib/providers/locale_provider.dart`

**Step 1: Create locale_provider.dart**

```dart
import 'package:flutter/cupertino.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('zh');
  
  Locale get locale => _locale;
  
  void setLocale(Locale locale) {
    if (locale.languageCode != 'zh' && locale.languageCode != 'en') {
      return;
    }
    _locale = locale;
    notifyListeners();
  }
  
  void toggleLocale() {
    _locale = _locale.languageCode == 'zh' 
        ? const Locale('en') 
        : const Locale('zh');
    notifyListeners();
  }
}
```

**Step 2: Commit**

```bash
git add flutter_app/lib/providers/
git commit -m "feat: add LocaleProvider for language switching"
```

---

### Task 7: Setup Router

**Files:**
- Create: `flutter_app/lib/core/router/app_router.dart`

**Step 1: Create app_router.dart**

```dart
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/home_screen.dart';
import '../../features/files/files_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/profile/edit_profile_screen.dart';
import '../../features/report/report_screen.dart';
import '../../features/notifications/notifications_screen.dart';
import '../../features/feedback/feedback_screen.dart';
import '../widgets/bottom_nav_scaffold.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BottomNavScaffold(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/files',
              builder: (context, state) => const FilesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
              routes: [
                GoRoute(
                  path: 'edit',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => const EditProfileScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/report/:id',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => ReportScreen(
        id: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/notifications',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: '/feedback',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const FeedbackScreen(),
    ),
  ],
);
```

**Step 2: Commit**

```bash
git add flutter_app/lib/core/router/
git commit -m "feat: configure go_router with tab navigation"
```

---

### Task 8: Create Bottom Navigation Scaffold

**Files:**
- Create: `flutter_app/lib/core/widgets/bottom_nav_scaffold.dart`

**Step 1: Create bottom_nav_scaffold.dart**

```dart
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomNavScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  
  const BottomNavScaffold({
    super.key,
    required this.navigationShell,
  });
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        activeColor: AppColors.primary,
        inactiveColor: AppColors.textTertiary,
        backgroundColor: AppColors.surface,
        border: Border(
          top: BorderSide(
            color: AppColors.border,
            width: 0.5,
          ),
        ),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.home),
            activeIcon: const Icon(CupertinoIcons.home, color: AppColors.primary),
            label: l10n.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.folder),
            activeIcon: const Icon(CupertinoIcons.folder_fill, color: AppColors.primary),
            label: l10n.files,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.settings),
            activeIcon: const Icon(CupertinoIcons.settings_solid, color: AppColors.primary),
            label: l10n.settings,
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return navigationShell;
      },
    );
  }
}
```

**Step 2: Commit**

```bash
git add flutter_app/lib/core/widgets/
git commit -m "feat: add bottom navigation scaffold"
```

---

### Task 9: Create Placeholder Screens

**Files:**
- Create: `flutter_app/lib/features/home/home_screen.dart`
- Create: `flutter_app/lib/features/files/files_screen.dart`
- Create: `flutter_app/lib/features/profile/profile_screen.dart`
- Create: `flutter_app/lib/features/profile/edit_profile_screen.dart`
- Create: `flutter_app/lib/features/report/report_screen.dart`
- Create: `flutter_app/lib/features/notifications/notifications_screen.dart`
- Create: `flutter_app/lib/features/feedback/feedback_screen.dart`

**Step 1: Create home_screen.dart**

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return CupertinoPageScaffold(
      child: Center(
        child: Text(l10n.home),
      ),
    );
  }
}
```

**Step 2: Create files_screen.dart**

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FilesScreen extends StatelessWidget {
  const FilesScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return CupertinoPageScaffold(
      child: Center(
        child: Text(l10n.files),
      ),
    );
  }
}
```

**Step 3: Create profile_screen.dart**

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return CupertinoPageScaffold(
      child: Center(
        child: Text(l10n.profile),
      ),
    );
  }
}
```

**Step 4: Create edit_profile_screen.dart**

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(l10n.editProfile),
      ),
      child: Center(
        child: Text(l10n.editProfile),
      ),
    );
  }
}
```

**Step 5: Create report_screen.dart**

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReportScreen extends StatelessWidget {
  final String id;
  
  const ReportScreen({super.key, required this.id});
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(l10n.reportDetails),
      ),
      child: Center(
        child: Text('Report #$id'),
      ),
    );
  }
}
```

**Step 6: Create notifications_screen.dart**

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(l10n.notifications),
      ),
      child: Center(
        child: Text(l10n.notifications),
      ),
    );
  }
}
```

**Step 7: Create feedback_screen.dart**

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(l10n.feedbackTitle),
      ),
      child: Center(
        child: Text(l10n.feedback),
      ),
    );
  }
}
```

**Step 8: Commit**

```bash
git add flutter_app/lib/features/
git commit -m "feat: add placeholder screens for all pages"
```

---

### Task 10: Setup Main App Entry

**Files:**
- Modify: `flutter_app/lib/main.dart`
- Create: `flutter_app/lib/app.dart`

**Step 1: Create app.dart**

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'providers/locale_provider.dart';

class MediScanApp extends StatelessWidget {
  const MediScanApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        return CupertinoApp.router(
          title: 'MediScan AI',
          theme: AppTheme.theme,
          locale: localeProvider.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('zh'),
          ],
          routerConfig: appRouter,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
```

**Step 2: Update main.dart**

```dart
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'providers/locale_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: const MediScanApp(),
    ),
  );
}
```

**Step 3: Generate l10n and verify build**

Run:
```bash
cd flutter_app && flutter gen-l10n && flutter analyze
```

Expected: No errors

**Step 4: Commit**

```bash
git add flutter_app/lib/main.dart flutter_app/lib/app.dart
git commit -m "feat: setup main app with providers and router"
```

---

## Phase 2: Backend Setup

### Task 11: Initialize Python Backend

**Files:**
- Create: `backend/` directory structure
- Create: `backend/pyproject.toml`
- Create: `backend/requirements.txt`

**Step 1: Create directory structure**

Run:
```bash
cd /home/shayne/work/ai-ct/.worktrees/flutter-migration
mkdir -p backend/app/{models,routers,schemas,services}
mkdir -p backend/tests
mkdir -p backend/alembic
touch backend/app/__init__.py
touch backend/app/models/__init__.py
touch backend/app/routers/__init__.py
touch backend/app/schemas/__init__.py
touch backend/app/services/__init__.py
touch backend/tests/__init__.py
```

**Step 2: Create pyproject.toml**

```toml
[project]
name = "mediscan-api"
version = "0.1.0"
description = "MediScan AI Backend API"
requires-python = ">=3.11"
dependencies = [
    "fastapi>=0.109.0",
    "uvicorn[standard]>=0.27.0",
    "sqlmodel>=0.0.14",
    "asyncpg>=0.29.0",
    "alembic>=1.13.0",
    "python-dotenv>=1.0.0",
    "python-multipart>=0.0.6",
]

[project.optional-dependencies]
dev = [
    "pytest>=7.4.0",
    "pytest-asyncio>=0.23.0",
    "httpx>=0.26.0",
]

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"
```

**Step 3: Create requirements.txt**

```
fastapi>=0.109.0
uvicorn[standard]>=0.27.0
sqlmodel>=0.0.14
asyncpg>=0.29.0
alembic>=1.13.0
python-dotenv>=1.0.0
python-multipart>=0.0.6
pytest>=7.4.0
pytest-asyncio>=0.23.0
httpx>=0.26.0
```

**Step 4: Commit**

```bash
git add backend/
git commit -m "feat: initialize Python backend structure"
```

---

### Task 12: Create Backend Config and Database

**Files:**
- Create: `backend/app/config.py`
- Create: `backend/app/database.py`
- Create: `backend/.env.example`

**Step 1: Create config.py**

```python
from pydantic_settings import BaseSettings
from functools import lru_cache


class Settings(BaseSettings):
    app_name: str = "MediScan API"
    debug: bool = False
    database_url: str = "postgresql+asyncpg://postgres:postgres@localhost:5432/mediscan"
    
    class Config:
        env_file = ".env"


@lru_cache
def get_settings() -> Settings:
    return Settings()
```

**Step 2: Create database.py**

```python
from sqlmodel import SQLModel, create_engine
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker
from .config import get_settings

settings = get_settings()

async_engine = create_async_engine(
    settings.database_url,
    echo=settings.debug,
    future=True,
)

async_session = sessionmaker(
    async_engine,
    class_=AsyncSession,
    expire_on_commit=False,
)


async def get_session() -> AsyncSession:
    async with async_session() as session:
        yield session


async def create_db_and_tables():
    async with async_engine.begin() as conn:
        await conn.run_sync(SQLModel.metadata.create_all)
```

**Step 3: Create .env.example**

```
DATABASE_URL=postgresql+asyncpg://postgres:postgres@localhost:5432/mediscan
DEBUG=true
```

**Step 4: Commit**

```bash
git add backend/app/config.py backend/app/database.py backend/.env.example
git commit -m "feat: add backend config and database connection"
```

---

### Task 13: Create SQLModel Models

**Files:**
- Create: `backend/app/models/user.py`
- Create: `backend/app/models/record.py`
- Create: `backend/app/models/notification.py`
- Create: `backend/app/models/feedback.py`

**Step 1: Create user.py**

```python
from datetime import date, datetime
from typing import Optional
from sqlmodel import Field, SQLModel


class UserBase(SQLModel):
    name: str
    phone: Optional[str] = None
    gender: Optional[str] = None
    birthday: Optional[date] = None
    avatar: Optional[str] = None
    height: Optional[int] = None
    weight: Optional[int] = None
    blood_type: Optional[str] = None


class User(UserBase, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    join_days: int = 0
    created_at: datetime = Field(default_factory=datetime.utcnow)
    updated_at: datetime = Field(default_factory=datetime.utcnow)


class UserCreate(UserBase):
    pass


class UserUpdate(SQLModel):
    name: Optional[str] = None
    phone: Optional[str] = None
    gender: Optional[str] = None
    birthday: Optional[date] = None
    avatar: Optional[str] = None
    height: Optional[int] = None
    weight: Optional[int] = None
    blood_type: Optional[str] = None


class UserRead(UserBase):
    id: int
    join_days: int
    created_at: datetime
```

**Step 2: Create record.py**

```python
from datetime import datetime
from typing import Optional
from sqlmodel import Field, SQLModel, JSON, Column


class RecordBase(SQLModel):
    title: str
    type: str  # CT, X-ray, MRI, Ultrasound
    status: str = "processing"  # completed, processing, attention, normal
    status_label: str = "Processing"
    thumbnail: Optional[str] = None
    scan_date: datetime


class Record(RecordBase, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    user_id: int = Field(foreign_key="user.id")
    report_data: Optional[dict] = Field(default=None, sa_column=Column(JSON))
    created_at: datetime = Field(default_factory=datetime.utcnow)


class RecordCreate(RecordBase):
    user_id: int


class RecordUpdate(SQLModel):
    title: Optional[str] = None
    status: Optional[str] = None
    status_label: Optional[str] = None
    report_data: Optional[dict] = None


class RecordRead(RecordBase):
    id: int
    user_id: int
    report_data: Optional[dict]
    created_at: datetime
```

**Step 3: Create notification.py**

```python
from datetime import datetime
from typing import Optional
from sqlmodel import Field, SQLModel


class NotificationBase(SQLModel):
    title: str
    description: str
    type: str = "system"  # report, system, health


class Notification(NotificationBase, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    user_id: int = Field(foreign_key="user.id")
    read: bool = False
    created_at: datetime = Field(default_factory=datetime.utcnow)


class NotificationCreate(NotificationBase):
    user_id: int


class NotificationRead(NotificationBase):
    id: int
    user_id: int
    read: bool
    created_at: datetime
```

**Step 4: Create feedback.py**

```python
from datetime import datetime
from typing import Optional, List
from sqlmodel import Field, SQLModel, JSON, Column


class FeedbackBase(SQLModel):
    content: str
    contact: Optional[str] = None


class Feedback(FeedbackBase, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    user_id: Optional[int] = Field(default=None, foreign_key="user.id")
    images: Optional[List[str]] = Field(default=None, sa_column=Column(JSON))
    created_at: datetime = Field(default_factory=datetime.utcnow)


class FeedbackCreate(FeedbackBase):
    user_id: Optional[int] = None
    images: Optional[List[str]] = None


class FeedbackRead(FeedbackBase):
    id: int
    user_id: Optional[int]
    images: Optional[List[str]]
    created_at: datetime
```

**Step 5: Update models/__init__.py**

```python
from .user import User, UserCreate, UserUpdate, UserRead
from .record import Record, RecordCreate, RecordUpdate, RecordRead
from .notification import Notification, NotificationCreate, NotificationRead
from .feedback import Feedback, FeedbackCreate, FeedbackRead

__all__ = [
    "User", "UserCreate", "UserUpdate", "UserRead",
    "Record", "RecordCreate", "RecordUpdate", "RecordRead",
    "Notification", "NotificationCreate", "NotificationRead",
    "Feedback", "FeedbackCreate", "FeedbackRead",
]
```

**Step 6: Commit**

```bash
git add backend/app/models/
git commit -m "feat: add SQLModel database models"
```

---

### Task 14: Create API Response Schema

**Files:**
- Create: `backend/app/schemas/response.py`

**Step 1: Create response.py**

```python
from typing import Generic, TypeVar, Optional
from pydantic import BaseModel

T = TypeVar("T")


class APIResponse(BaseModel, Generic[T]):
    code: int = 0
    message: str = "success"
    data: Optional[T] = None
    
    @classmethod
    def success(cls, data: T = None, message: str = "success"):
        return cls(code=0, message=message, data=data)
    
    @classmethod
    def error(cls, message: str, code: int = 1):
        return cls(code=code, message=message, data=None)


class PaginatedData(BaseModel, Generic[T]):
    items: list[T]
    total: int
    page: int
    page_size: int
```

**Step 2: Update schemas/__init__.py**

```python
from .response import APIResponse, PaginatedData

__all__ = ["APIResponse", "PaginatedData"]
```

**Step 3: Commit**

```bash
git add backend/app/schemas/
git commit -m "feat: add API response schemas"
```

---

### Task 15: Create API Routers

**Files:**
- Create: `backend/app/routers/users.py`
- Create: `backend/app/routers/records.py`
- Create: `backend/app/routers/notifications.py`
- Create: `backend/app/routers/feedback.py`
- Create: `backend/app/routers/upload.py`

**Step 1: Create users.py**

```python
from fastapi import APIRouter, Depends, HTTPException
from sqlmodel import select
from sqlalchemy.ext.asyncio import AsyncSession
from ..database import get_session
from ..models import User, UserCreate, UserUpdate, UserRead
from ..schemas import APIResponse

router = APIRouter(prefix="/api/users", tags=["users"])


@router.get("/{user_id}", response_model=APIResponse[UserRead])
async def get_user(user_id: int, session: AsyncSession = Depends(get_session)):
    user = await session.get(User, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return APIResponse.success(UserRead.model_validate(user))


@router.put("/{user_id}", response_model=APIResponse[UserRead])
async def update_user(
    user_id: int,
    user_update: UserUpdate,
    session: AsyncSession = Depends(get_session),
):
    user = await session.get(User, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    
    for key, value in user_update.model_dump(exclude_unset=True).items():
        setattr(user, key, value)
    
    session.add(user)
    await session.commit()
    await session.refresh(user)
    return APIResponse.success(UserRead.model_validate(user))
```

**Step 2: Create records.py**

```python
from typing import Optional
from fastapi import APIRouter, Depends, HTTPException, Query
from sqlmodel import select, func
from sqlalchemy.ext.asyncio import AsyncSession
from ..database import get_session
from ..models import Record, RecordCreate, RecordUpdate, RecordRead
from ..schemas import APIResponse, PaginatedData

router = APIRouter(prefix="/api/records", tags=["records"])


@router.get("", response_model=APIResponse[PaginatedData[RecordRead]])
async def list_records(
    user_id: Optional[int] = Query(None),
    status: Optional[str] = Query(None),
    page: int = Query(1, ge=1),
    page_size: int = Query(10, ge=1, le=100),
    session: AsyncSession = Depends(get_session),
):
    query = select(Record)
    count_query = select(func.count()).select_from(Record)
    
    if user_id:
        query = query.where(Record.user_id == user_id)
        count_query = count_query.where(Record.user_id == user_id)
    if status:
        query = query.where(Record.status == status)
        count_query = count_query.where(Record.status == status)
    
    total = (await session.execute(count_query)).scalar() or 0
    query = query.offset((page - 1) * page_size).limit(page_size)
    query = query.order_by(Record.created_at.desc())
    
    result = await session.execute(query)
    records = result.scalars().all()
    
    return APIResponse.success(
        PaginatedData(
            items=[RecordRead.model_validate(r) for r in records],
            total=total,
            page=page,
            page_size=page_size,
        )
    )


@router.get("/{record_id}", response_model=APIResponse[RecordRead])
async def get_record(record_id: int, session: AsyncSession = Depends(get_session)):
    record = await session.get(Record, record_id)
    if not record:
        raise HTTPException(status_code=404, detail="Record not found")
    return APIResponse.success(RecordRead.model_validate(record))


@router.post("", response_model=APIResponse[RecordRead])
async def create_record(
    record: RecordCreate,
    session: AsyncSession = Depends(get_session),
):
    db_record = Record.model_validate(record)
    session.add(db_record)
    await session.commit()
    await session.refresh(db_record)
    return APIResponse.success(RecordRead.model_validate(db_record))


@router.delete("/{record_id}", response_model=APIResponse)
async def delete_record(record_id: int, session: AsyncSession = Depends(get_session)):
    record = await session.get(Record, record_id)
    if not record:
        raise HTTPException(status_code=404, detail="Record not found")
    await session.delete(record)
    await session.commit()
    return APIResponse.success(message="Record deleted")
```

**Step 3: Create notifications.py**

```python
from typing import Optional
from fastapi import APIRouter, Depends, HTTPException, Query
from sqlmodel import select
from sqlalchemy.ext.asyncio import AsyncSession
from ..database import get_session
from ..models import Notification, NotificationRead
from ..schemas import APIResponse

router = APIRouter(prefix="/api/notifications", tags=["notifications"])


@router.get("", response_model=APIResponse[list[NotificationRead]])
async def list_notifications(
    user_id: int = Query(...),
    type: Optional[str] = Query(None),
    session: AsyncSession = Depends(get_session),
):
    query = select(Notification).where(Notification.user_id == user_id)
    if type:
        query = query.where(Notification.type == type)
    query = query.order_by(Notification.created_at.desc())
    
    result = await session.execute(query)
    notifications = result.scalars().all()
    return APIResponse.success([NotificationRead.model_validate(n) for n in notifications])


@router.put("/{notification_id}/read", response_model=APIResponse)
async def mark_read(notification_id: int, session: AsyncSession = Depends(get_session)):
    notification = await session.get(Notification, notification_id)
    if not notification:
        raise HTTPException(status_code=404, detail="Notification not found")
    notification.read = True
    session.add(notification)
    await session.commit()
    return APIResponse.success(message="Marked as read")


@router.put("/read-all", response_model=APIResponse)
async def mark_all_read(
    user_id: int = Query(...),
    session: AsyncSession = Depends(get_session),
):
    query = select(Notification).where(
        Notification.user_id == user_id,
        Notification.read == False,
    )
    result = await session.execute(query)
    notifications = result.scalars().all()
    
    for n in notifications:
        n.read = True
        session.add(n)
    
    await session.commit()
    return APIResponse.success(message=f"Marked {len(notifications)} as read")
```

**Step 4: Create feedback.py**

```python
from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from ..database import get_session
from ..models import Feedback, FeedbackCreate, FeedbackRead
from ..schemas import APIResponse

router = APIRouter(prefix="/api/feedback", tags=["feedback"])


@router.post("", response_model=APIResponse[FeedbackRead])
async def create_feedback(
    feedback: FeedbackCreate,
    session: AsyncSession = Depends(get_session),
):
    db_feedback = Feedback.model_validate(feedback)
    session.add(db_feedback)
    await session.commit()
    await session.refresh(db_feedback)
    return APIResponse.success(FeedbackRead.model_validate(db_feedback))
```

**Step 5: Create upload.py**

```python
import uuid
from pathlib import Path
from fastapi import APIRouter, UploadFile, File
from ..schemas import APIResponse

router = APIRouter(prefix="/api/upload", tags=["upload"])

UPLOAD_DIR = Path("uploads")
UPLOAD_DIR.mkdir(exist_ok=True)


@router.post("/image", response_model=APIResponse[dict])
async def upload_image(file: UploadFile = File(...)):
    ext = Path(file.filename).suffix
    filename = f"{uuid.uuid4()}{ext}"
    filepath = UPLOAD_DIR / filename
    
    content = await file.read()
    with open(filepath, "wb") as f:
        f.write(content)
    
    return APIResponse.success({"url": f"/uploads/{filename}"})
```

**Step 6: Update routers/__init__.py**

```python
from .users import router as users_router
from .records import router as records_router
from .notifications import router as notifications_router
from .feedback import router as feedback_router
from .upload import router as upload_router

__all__ = [
    "users_router",
    "records_router",
    "notifications_router",
    "feedback_router",
    "upload_router",
]
```

**Step 7: Commit**

```bash
git add backend/app/routers/
git commit -m "feat: add API routers for all endpoints"
```

---

### Task 16: Create FastAPI Main Entry

**Files:**
- Create: `backend/app/main.py`

**Step 1: Create main.py**

```python
from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from pathlib import Path

from .config import get_settings
from .database import create_db_and_tables
from .routers import (
    users_router,
    records_router,
    notifications_router,
    feedback_router,
    upload_router,
)

settings = get_settings()


@asynccontextmanager
async def lifespan(app: FastAPI):
    await create_db_and_tables()
    yield


app = FastAPI(
    title=settings.app_name,
    version="0.1.0",
    lifespan=lifespan,
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Mount uploads directory
uploads_dir = Path("uploads")
uploads_dir.mkdir(exist_ok=True)
app.mount("/uploads", StaticFiles(directory=uploads_dir), name="uploads")

# Include routers
app.include_router(users_router)
app.include_router(records_router)
app.include_router(notifications_router)
app.include_router(feedback_router)
app.include_router(upload_router)


@app.get("/health")
async def health_check():
    return {"status": "healthy"}
```

**Step 2: Commit**

```bash
git add backend/app/main.py
git commit -m "feat: add FastAPI main entry with CORS and routers"
```

---

### Task 17: Add Docker Support

**Files:**
- Create: `backend/Dockerfile`
- Create: `docker-compose.yml`

**Step 1: Create backend/Dockerfile**

```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ app/

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

**Step 2: Create docker-compose.yml at project root**

```yaml
version: "3.8"

services:
  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: mediscan
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

  api:
    build: ./backend
    ports:
      - "8000:8000"
    environment:
      DATABASE_URL: postgresql+asyncpg://postgres:postgres@db:5432/mediscan
      DEBUG: "true"
    depends_on:
      - db
    volumes:
      - ./backend/uploads:/app/uploads

volumes:
  postgres_data:
```

**Step 3: Commit**

```bash
git add backend/Dockerfile docker-compose.yml
git commit -m "feat: add Docker support for backend and database"
```

---

## Phase 3: Implement UI Screens

### Task 18: Implement HomeScreen

**Files:**
- Modify: `flutter_app/lib/features/home/home_screen.dart`
- Create: `flutter_app/lib/features/home/widgets/record_card.dart`

**Step 1: Create record_card.dart**

```dart
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../models/record.dart';

class RecordCard extends StatelessWidget {
  final Record record;
  final VoidCallback onTap;
  
  const RecordCard({
    super.key,
    required this.record,
    required this.onTap,
  });
  
  Color get _statusColor {
    switch (record.status) {
      case RecordStatus.completed:
      case RecordStatus.normal:
        return AppColors.success;
      case RecordStatus.processing:
        return AppColors.warning;
      case RecordStatus.attention:
        return AppColors.warning;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppTheme.cardRadius,
          boxShadow: AppTheme.cardShadow,
        ),
        child: Row(
          children: [
            // Thumbnail
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAlias,
              child: record.thumbnail != null
                  ? CachedNetworkImage(
                      imageUrl: record.thumbnail!,
                      fit: BoxFit.cover,
                    )
                  : const Icon(
                      CupertinoIcons.doc_text,
                      color: AppColors.textTertiary,
                    ),
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          record.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          record.statusLabel,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: _statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    record.type,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    record.time,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              CupertinoIcons.chevron_right,
              color: AppColors.textTertiary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
```

**Step 2: Update home_screen.dart**

```dart
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../models/record.dart';
import 'widgets/record_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  // Mock data
  List<Record> get _recentRecords => [
    const Record(
      id: '48291',
      title: '胸部 CT 检测报告',
      date: '2023-10-24',
      time: '10 分钟前',
      type: 'AI 深度分析 • 肺部影像',
      thumbnail: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCE1pPA9AwYpUrLPUpMzfFjA1eG4bG1BmA5_69qnqlfvtV_JWHGYpQXRYGabIqfZE1jwDSU-X33hQwVnNinMOa7MbGypbAvUjcU7t6oRkZof6v-o0BlkIGos8VZFdwRViYLPSYfl5NVt8-XxFeUFRNUzHsNNHUvGE4qCF33vmcy-MZM7aaNVQq4uiqprNXoqAOTV7hnkOGNUTSD-lSsJ9RSd_mipxncaNgSy8J3QUrKI0IOYLGVf5YlGUiUWdP8o90AwfjKctlbSqU',
      status: RecordStatus.completed,
      statusLabel: '已生成',
    ),
    const Record(
      id: 'processing',
      title: '头部 CT 影像',
      date: '2023-10-24',
      time: '2 小时前',
      type: '正在进行 AI 运算...',
      status: RecordStatus.processing,
      statusLabel: '分析中',
    ),
    const Record(
      id: 'normal',
      title: '腹部常规检查',
      date: '2023-10-23',
      time: '昨天',
      type: '无明显异常发现',
      status: RecordStatus.normal,
      statusLabel: '已生成',
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return CupertinoPageScaffold(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.border,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.2),
                              width: 2,
                            ),
                          ),
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuC33gh9r-8-pxjOXB1uN9xTy7RcOrZgQavPv2LY5DJj6PCE--fJMiO34VxV7Rv4X2IPI8fiZoUoUkV9lRsTtsCNnCuYSNT4BQHADLv6GxSbseV07zo-fBYT8LuIvtEpQWJ0DEZjjfCYF2I_e0arMsJUngaD0uJ4eP6-tZd8iJA8PsWeYMIRbtlua9rpkWoIjxVYV26_-Y9LjGyDw-pw4Y37pkfMfam_DPw7w0wpbBLHZH6P1nRnBr-XFUVvTzoZQW3e0RoXE0JdgEs',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.profile,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const Text(
                              '张伟',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => context.push('/notifications'),
                      child: Stack(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              CupertinoIcons.bell,
                              color: AppColors.textSecondary,
                              size: 20,
                            ),
                          ),
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.error,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Greeting & Upload Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.greeting('张伟'),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.uploadHint,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Upload Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: AppTheme.cardRadius,
                        boxShadow: AppTheme.cardShadow,
                      ),
                      child: Column(
                        children: [
                          // Main Button
                          Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: AppTheme.buttonRadius,
                              boxShadow: AppTheme.floatShadow,
                            ),
                            child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    CupertinoIcons.sparkles,
                                    color: CupertinoColors.white,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    l10n.startAnalysis,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: CupertinoColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // Divider
                          Row(
                            children: [
                              const Expanded(child: Divider(color: AppColors.border)),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  '其他方式',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textTertiary,
                                  ),
                                ),
                              ),
                              const Expanded(child: Divider(color: AppColors.border)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          // Secondary Buttons
                          Row(
                            children: [
                              Expanded(
                                child: _buildSecondaryButton(
                                  icon: CupertinoIcons.camera,
                                  label: l10n.takePhoto,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildSecondaryButton(
                                  icon: CupertinoIcons.photo,
                                  label: l10n.chooseAlbum,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Recent Records Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.recentRecords,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => context.go('/files'),
                      child: Text(
                        l10n.viewAll,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Records List
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final record = _recentRecords[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: RecordCard(
                        record: record,
                        onTap: () {
                          if (record.status != RecordStatus.processing) {
                            context.push('/report/${record.id}');
                          }
                        },
                      ),
                    );
                  },
                  childCount: _recentRecords.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSecondaryButton({
    required IconData icon,
    required String label,
  }) {
    return Container(
      height: 96,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: AppTheme.buttonRadius,
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.primary,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

**Step 3: Commit**

```bash
git add flutter_app/lib/features/home/
git commit -m "feat: implement HomeScreen with record cards"
```

---

### Task 19-24: Implement Remaining Screens

_(Due to plan length, detailed implementation for FilesScreen, ProfileScreen, EditProfileScreen, ReportScreen, NotificationsScreen, and FeedbackScreen follows the same pattern as HomeScreen. Each screen will:_

1. _Create any necessary widget files in `widgets/` subfolder_
2. _Implement the main screen with Cupertino components_
3. _Use l10n for all user-facing text_
4. _Use AppColors and AppTheme consistently_
5. _Commit after each screen_

_The structure mirrors the React components analyzed earlier.)_

---

## Phase 4: Final Integration

### Task 25: Verify Full Build

**Step 1: Run Flutter analyze**

Run:
```bash
cd flutter_app && flutter analyze
```

Expected: No issues found

**Step 2: Build iOS**

Run:
```bash
cd flutter_app && flutter build ios --simulator
```

Expected: Build successful

**Step 3: Build Android**

Run:
```bash
cd flutter_app && flutter build apk --debug
```

Expected: Build successful

**Step 4: Commit**

```bash
git add -A
git commit -m "feat: complete Flutter migration with all screens"
```

---

### Task 26: Verify Backend

**Step 1: Start backend services**

Run:
```bash
docker-compose up -d
```

Expected: Both db and api containers running

**Step 2: Check API health**

Run:
```bash
curl http://localhost:8000/health
```

Expected: `{"status": "healthy"}`

**Step 3: Check API docs**

Run:
```bash
curl -s http://localhost:8000/docs | head -20
```

Expected: Swagger UI HTML

---

### Task 27: Final Commit and Push

**Step 1: Final commit**

```bash
git add -A
git commit -m "chore: finalize Flutter migration"
```

**Step 2: Push branch**

```bash
git push -u origin feature/flutter-migration
```

---

## Summary

| Phase | Tasks | Description |
|-------|-------|-------------|
| 1 | 1-10 | Flutter project setup, dependencies, theme, models, router |
| 2 | 11-17 | Python backend setup, models, API routers, Docker |
| 3 | 18-24 | Implement all 7 UI screens |
| 4 | 25-27 | Build verification and final push |

**Total commits:** ~20
**Estimated time:** 4-6 hours
