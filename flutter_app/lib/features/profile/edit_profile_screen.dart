import 'package:flutter/cupertino.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Edit Profile'),
      ),
      child: const Center(
        child: Text('Edit Profile'),
      ),
    );
  }
}
