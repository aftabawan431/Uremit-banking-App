import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/providers/date_time_provider.dart';
import 'package:uremit/features/home/presentation/manager/home_view_model.dart';

import '../../../../../app/globals.dart';
import '../manager/update_profile_view_model.dart';
import '../widgets/update_profile_page_content.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final HomeViewModel _viewModel = sl();
  final UpdateProfileViewModel _viewModel2 = sl();
  final DateTimeProvider _dateTimeProvider = sl();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: _viewModel),
            ChangeNotifierProvider.value(value: _viewModel2),
            ChangeNotifierProvider.value(value: _dateTimeProvider),
          ],
          builder: (context, child) {
            return const UpdateProfilePageContent();
          },
        ),
      ),
    );
  }
}
