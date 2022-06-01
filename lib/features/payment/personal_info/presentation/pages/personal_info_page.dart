import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/providers/date_time_provider.dart';
import 'package:uremit/features/home/presentation/manager/home_view_model.dart';

import '../../../../../app/globals.dart';
import '../../../../menu/profile/presentation/manager/profile_view_model.dart';
import '../manager/personal_info_view_model.dart';
import '../widgets/personal_info_page_content.dart';

class ProfileInfoPage extends StatefulWidget {
  const ProfileInfoPage({Key? key}) : super(key: key);

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  final ProfileInfoViewModel _viewModel = sl();
  final ProfileViewModel _viewModel2 = sl();
  final HomeViewModel _viewModel3 = sl();
  final DateTimeProvider _dateTimeProvider = sl();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: _viewModel),
            ChangeNotifierProvider.value(value: _dateTimeProvider),
            ChangeNotifierProvider.value(value: _viewModel2),
            ChangeNotifierProvider.value(value: _viewModel3),
          ],
          builder: (context, child) {
            return const ProfileInfoPageContent();
          },
        ),
      ),
    );
  }
}
