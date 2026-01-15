# MediScan AI - Flutter 迁移设计文档

**日期**: 2026-01-15  
**状态**: 已确认

---

## 概述

将现有 React/TypeScript Web 应用迁移为 Flutter 跨平台移动应用，同时新增 Python 后端。

---

## 前端（Flutter）

### 技术选型

| 类别 | 选择 |
|------|------|
| 框架 | Flutter 3.x (stable) |
| 最低支持 | iOS 12.0 / Android API 21 |
| 状态管理 | Provider |
| 路由 | go_router |
| UI 风格 | Cupertino（统一 iOS 体验） |
| 国际化 | flutter_localizations + intl (ARB) |
| 项目结构 | Feature-first |

### 项目结构

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── theme/
│   │   └── app_theme.dart
│   ├── l10n/
│   │   ├── app_en.arb
│   │   ├── app_zh.arb
│   │   └── l10n.dart
│   └── widgets/
│       └── bottom_nav.dart
├── features/
│   ├── home/
│   │   ├── home_screen.dart
│   │   └── widgets/
│   ├── report/
│   │   ├── report_screen.dart
│   │   └── widgets/
│   ├── files/
│   ├── profile/
│   ├── notifications/
│   └── feedback/
├── models/
│   ├── record.dart
│   ├── notification.dart
│   └── user_profile.dart
└── providers/
    └── locale_provider.dart
```

### 设计系统

#### 颜色

```dart
// 主色
primary: Color(0xFF137FEC)      // 品牌蓝
primaryDark: Color(0xFF0B66C3)  // 按压态

// 背景
background: Color(0xFFF6F7F8)   // 页面背景
surface: Color(0xFFFFFFFF)      // 卡片背景

// 文字
textPrimary: Color(0xFF0F172A)   // slate-900 标题
textSecondary: Color(0xFF64748B) // slate-500 正文
textTertiary: Color(0xFF94A3B8)  // slate-400 辅助

// 状态色
success: Color(0xFF16A34A)       // 绿色 - 正常/完成
warning: Color(0xFFD97706)       // 琥珀色 - 分析中/需关注
error: Color(0xFFEF4444)         // 红色 - 退出/删除
```

#### 阴影

```dart
cardShadow: BoxShadow(
  color: Colors.black.withOpacity(0.04),
  blurRadius: 8,
  offset: Offset(0, 2),
)

floatShadow: BoxShadow(
  color: Color(0xFF137FEC).withOpacity(0.3),
  blurRadius: 12,
  offset: Offset(0, 4),
)
```

### 页面与路由

| 路由 | 页面 | 底部导航 | 说明 |
|------|------|----------|------|
| `/` | HomeScreen | ✅ | 首页，上传入口，最近记录 |
| `/files` | FilesScreen | ✅ | 健康档案列表，按月分组 |
| `/profile` | ProfileScreen | ✅ | 个人中心，设置菜单 |
| `/report/:id` | ReportScreen | ❌ | 报告详情，风险评估 |
| `/profile/edit` | EditProfileScreen | ❌ | 编辑个人资料 |
| `/notifications` | NotificationsScreen | ❌ | 消息通知，带 Tab 切换 |
| `/feedback` | FeedbackScreen | ❌ | 意见反馈与帮助 |

#### 底部导航（3 Tab）

```
┌─────────┬─────────┬─────────┐
│  首页   │  档案   │  设置   │
│  home   │ folder  │settings │
└─────────┴─────────┴─────────┘
```

#### go_router 配置

```dart
StatefulShellRoute.indexedStack(
  branches: [
    // Tab 1: 首页
    StatefulShellBranch(routes: [GoRoute(path: '/')]),
    // Tab 2: 档案  
    StatefulShellBranch(routes: [GoRoute(path: '/files')]),
    // Tab 3: 设置
    StatefulShellBranch(routes: [
      GoRoute(path: '/profile', routes: [
        GoRoute(path: 'edit'),  // /profile/edit
      ]),
    ]),
  ],
)
// 独立路由
GoRoute(path: '/report/:id')
GoRoute(path: '/notifications')
GoRoute(path: '/feedback')
```

### 数据模型（Dart）

```dart
// record.dart
enum RecordStatus { completed, processing, attention, normal }

class Record {
  final String id;
  final String title;
  final String date;
  final String time;
  final String type;          // CT、X光、MRI 等
  final String? thumbnail;
  final RecordStatus status;
  final String statusLabel;   // "已生成"、"分析中" 等
}

// notification.dart
enum NotificationType { report, system, health }

class AppNotification {
  final int id;
  final String title;
  final String description;
  final String time;
  final NotificationType type;
  final bool read;
}

// user_profile.dart
class UserProfile {
  final String name;
  final String id;
  final int joinDays;
  final String? avatar;
  
  // 扩展字段（EditProfile 页面用）
  final String? gender;
  final String? birthday;
  final String? phone;
  final int? height;
  final int? weight;
  final String? bloodType;
}
```

### 国际化字符串

#### 通用

| Key | 中文 | English |
|-----|------|---------|
| appName | MediScan AI | MediScan AI |
| home | 首页 | Home |
| files | 档案 | Files |
| settings | 设置 | Settings |
| save | 保存 | Save |
| cancel | 取消 | Cancel |
| viewAll | 查看全部 | View All |

#### 首页

| Key | 中文 | English |
|-----|------|---------|
| greeting | 您好，{name} | Hello, {name} |
| uploadHint | 上传您的影像资料，获取AI健康解析。 | Upload your scans for AI health analysis. |
| startAnalysis | 开始AI分析 | Start AI Analysis |
| takePhoto | 拍照上传 | Take Photo |
| chooseAlbum | 从相册选择 | Choose from Album |
| recentRecords | 最近记录 | Recent Records |

#### 状态

| Key | 中文 | English |
|-----|------|---------|
| statusCompleted | 已生成 | Completed |
| statusProcessing | 分析中 | Processing |
| statusNormal | 未见异常 | Normal |
| statusAttention | 建议随访 | Follow-up |

---

## 后端（Python）

### 技术选型

| 类别 | 选择 |
|------|------|
| 框架 | Python 3.11+ / FastAPI |
| 数据库 | PostgreSQL 15+ |
| ORM | SQLModel |
| 迁移 | Alembic |
| 认证 | 暂不实现 |
| API 文档 | Swagger/OpenAPI（内置） |

### 项目结构

```
backend/
├── app/
│   ├── __init__.py
│   ├── main.py              # FastAPI 入口
│   ├── config.py            # 环境配置
│   ├── database.py          # 数据库连接
│   ├── models/              # SQLModel 模型
│   │   ├── record.py
│   │   ├── notification.py
│   │   └── user.py
│   ├── schemas/             # Pydantic schemas
│   ├── routers/             # API 路由
│   │   ├── records.py
│   │   ├── notifications.py
│   │   ├── users.py
│   │   └── feedback.py
│   └── services/            # 业务逻辑
├── alembic/                 # 数据库迁移
├── tests/
├── requirements.txt
├── pyproject.toml
└── Dockerfile
```

### 数据库模型（SQLModel）

```python
# models/user.py
class User(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    name: str
    phone: str | None
    gender: str | None           # male, female
    birthday: date | None
    avatar: str | None
    height: int | None           # cm
    weight: int | None           # kg
    blood_type: str | None       # A, B, AB, O
    join_days: int = 0
    created_at: datetime
    updated_at: datetime

# models/record.py
class Record(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    user_id: int = Field(foreign_key="user.id")
    title: str                   # "胸部CT扫描"
    type: str                    # CT, X-ray, MRI, Ultrasound
    status: str                  # completed, processing, attention, normal
    status_label: str            # "已生成", "分析中"
    thumbnail: str | None
    report_data: dict | None     # JSONB - AI 分析结果
    scan_date: datetime
    created_at: datetime

# models/notification.py
class Notification(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    user_id: int = Field(foreign_key="user.id")
    title: str
    description: str
    type: str                    # report, system, health
    read: bool = False
    created_at: datetime

# models/feedback.py
class Feedback(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    user_id: int | None = Field(foreign_key="user.id")
    content: str
    contact: str | None          # 邮箱或手机
    images: list[str] | None     # 图片 URL 列表
    created_at: datetime
```

### API 端点

| 方法 | 路径 | 说明 |
|------|------|------|
| **用户** |||
| GET | `/api/users/{id}` | 获取用户信息 |
| PUT | `/api/users/{id}` | 更新用户资料 |
| **记录** |||
| GET | `/api/records` | 获取记录列表（支持分页、筛选） |
| GET | `/api/records/{id}` | 获取记录详情 + 报告 |
| POST | `/api/records` | 创建新记录（上传影像） |
| DELETE | `/api/records/{id}` | 删除记录 |
| **通知** |||
| GET | `/api/notifications` | 获取通知列表（支持 type 筛选） |
| PUT | `/api/notifications/{id}/read` | 标记已读 |
| PUT | `/api/notifications/read-all` | 全部已读 |
| **反馈** |||
| POST | `/api/feedback` | 提交反馈 |
| **文件上传** |||
| POST | `/api/upload/image` | 上传图片（返回 URL） |

### 响应格式

```json
{
  "code": 0,
  "message": "success",
  "data": { ... }
}
```

---

## 范围

### 包含

- 7 个页面 UI（Home、Files、Profile、Report、EditProfile、Notifications、Feedback）
- 底部导航（3 Tab）
- 中英文切换
- CRUD API（用户、记录、通知、反馈）
- 图片上传接口

### 不包含（YAGNI）

- AI 分析功能
- 用户认证/登录
- 推送通知
- 数据加密
