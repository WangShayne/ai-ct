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
  
  void _onItemTapped(BuildContext context, int index) {
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
  }
  
  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);
    
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          // Main content area with bottom padding for tab bar
          Positioned.fill(
            bottom: 83, // CupertinoTabBar height + safe area
            child: child,
          ),
          // Bottom navigation bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border(
                  top: BorderSide(
                    color: AppColors.borderLight,
                    width: 0.5,
                  ),
                ),
              ),
              child: SafeArea(
                top: false,
                child: SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(
                        context,
                        index: 0,
                        icon: CupertinoIcons.home,
                        label: 'Home',
                        isSelected: selectedIndex == 0,
                      ),
                      _buildNavItem(
                        context,
                        index: 1,
                        icon: CupertinoIcons.folder,
                        label: 'Files',
                        isSelected: selectedIndex == 1,
                      ),
                      _buildNavItem(
                        context,
                        index: 2,
                        icon: CupertinoIcons.settings,
                        label: 'Settings',
                        isSelected: selectedIndex == 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    final color = isSelected ? AppColors.primary : AppColors.textTertiary;
    
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _onItemTapped(context, index),
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: color,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
