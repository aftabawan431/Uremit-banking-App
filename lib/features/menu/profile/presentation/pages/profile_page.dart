import 'package:flutter/material.dart';
import 'package:uremit/features/menu/profile/presentation/manager/profile_view_model.dart';

import '../../../../../app/globals.dart';
import '../widgets/profile_page_content.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileViewModel _viewModel = sl();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: ProfilePageContent(),
        // ChangeNotifierProvider.value(
        //   value: _viewModel,
        //   builder: (context, snapshot) {
        //     return const ProfilePageContent();
        //   },
        // ),
      ),
    );
  }
}
