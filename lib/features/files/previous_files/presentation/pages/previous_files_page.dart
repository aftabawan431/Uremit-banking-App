import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/files/previous_files/presentation/manager/previous_files_view_model.dart';
import 'package:uremit/features/files/previous_files/presentation/widgets/previous_files_page_content.dart';

import '../../../../../app/globals.dart';

class PreviousFilesPage extends StatefulWidget {
  const PreviousFilesPage({Key? key}) : super(key: key);

  @override
  State<PreviousFilesPage> createState() => _PreviousFilesPageState();
}

class _PreviousFilesPageState extends State<PreviousFilesPage> {
  final PreviousFilesViewModel _viewModel = sl();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ChangeNotifierProvider.value(
          value: _viewModel,
          builder: (context, snapshot) {
            return const PreviousFilesPageContent();
          },
        ),
      ),
    );
  }
}
