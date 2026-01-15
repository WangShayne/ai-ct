import 'package:flutter/cupertino.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Notifications'),
      ),
      child: const Center(
        child: Text('Notifications'),
      ),
    );
  }
}
