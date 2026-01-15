import 'package:flutter/cupertino.dart';

class ReportScreen extends StatelessWidget {
  final String id;
  
  const ReportScreen({super.key, required this.id});
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Report Details'),
      ),
      child: Center(
        child: Text('Report #$id'),
      ),
    );
  }
}
