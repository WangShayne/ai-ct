import 'package:flutter/cupertino.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Feedback'),
      ),
      child: const Center(
        child: Text('Feedback'),
      ),
    );
  }
}
