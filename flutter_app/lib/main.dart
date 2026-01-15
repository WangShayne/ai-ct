import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'core/api/api_client.dart';
import 'providers/locale_provider.dart';
import 'providers/record_provider.dart';
import 'providers/notification_provider.dart';
import 'providers/user_provider.dart';

void main() {
  // Create shared API client
  final apiClient = ApiClient();
  
  runApp(
    MultiProvider(
      providers: [
        // Core providers
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        
        // Data providers with API client
        ChangeNotifierProvider(create: (_) => RecordProvider(apiClient)),
        ChangeNotifierProvider(create: (_) => NotificationProvider(apiClient)),
        ChangeNotifierProvider(create: (_) => UserProvider(apiClient)),
        
        // Provide the API client for direct access if needed
        Provider<ApiClient>.value(value: apiClient),
      ],
      child: const MediScanApp(),
    ),
  );
}
