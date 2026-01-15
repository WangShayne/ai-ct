import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';

class BottomNavScaffold extends StatelessWidget {
  final Widget child;
  
  const BottomNavScaffold({
    super.key,
    required this.child,
  });
  
  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/files')) return 1;
    if (location.startsWith('/profile')) return 2;
    return 0;
  }
  
  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);
    
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/files');
              break;
            case 2:
              context.go('/profile');
              break;
          }
        },
        activeColor: AppColors.primary,
        inactiveColor: AppColors.textTertiary,
        backgroundColor: AppColors.surface,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.folder),
            label: 'Files',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: 'Settings',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return child;
      },
    );
  }
}
