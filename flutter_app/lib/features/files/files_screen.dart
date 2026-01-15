import 'package:flutter/cupertino.dart';

class FilesScreen extends StatelessWidget {
  const FilesScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: Text('Files'),
      ),
    );
  }
}
