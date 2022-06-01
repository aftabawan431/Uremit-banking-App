import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/menu/documents/presentation/widgets/documents_page_content.dart';

import '../../../../../app/globals.dart';
import '../../../../../app/providers/date_time_provider.dart';
import '../manager/documents_view_model.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({Key? key}) : super(key: key);

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  final DocumentsViewModel _viewModel = sl();
  final DateTimeProvider _dateTimeProvider = sl();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: _dateTimeProvider),
            ChangeNotifierProvider.value(value: _viewModel),
          ],
          builder: (context, snapshot) {
            return const DocumentsPageContent();
          },
        ),
      ),
    );
  }
}
