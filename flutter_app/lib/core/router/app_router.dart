import 'package:go_router/go_router.dart';
import '../../features/home/home_screen.dart';
import '../../features/files/files_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/profile/edit_profile_screen.dart';
import '../../features/report/report_screen.dart';
import '../../features/notifications/notifications_screen.dart';
import '../../features/feedback/feedback_screen.dart';
import '../widgets/bottom_nav_scaffold.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return BottomNavScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/files',
          builder: (context, state) => const FilesScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/profile/edit',
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      path: '/report/:id',
      builder: (context, state) => ReportScreen(
        id: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: '/feedback',
      builder: (context, state) => const FeedbackScreen(),
    ),
  ],
);
