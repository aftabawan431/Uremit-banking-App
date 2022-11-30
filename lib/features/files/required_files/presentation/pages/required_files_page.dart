import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../app/globals.dart';
import '../../../../menu/documents/presentation/manager/documents_view_model.dart';
import '../manager/required_file_view_model.dart';
import '../widgets/required_files_page_content.dart';

class RequiredFilesPage extends StatefulWidget {
  const RequiredFilesPage({Key? key}) : super(key: key);

  @override
  State<RequiredFilesPage> createState() => _RequiredFilesPageState();
}

class _RequiredFilesPageState extends State<RequiredFilesPage> {
  final RequiredFilesViewModel _viewModel = sl();
  final DocumentsViewModel _documentsViewModel = sl();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: _viewModel,
            ),
            ChangeNotifierProvider.value(
              value: _documentsViewModel,
            )
          ],
          builder: (context, snapshot) {
            return const RequiredFilesPageContent();
          },
        ),
      ),
    );
  }
}
