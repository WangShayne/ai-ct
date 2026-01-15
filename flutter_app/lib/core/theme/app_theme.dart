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
