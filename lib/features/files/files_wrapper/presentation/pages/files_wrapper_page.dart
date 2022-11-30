import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/files/files_wrapper/presentation/manager/files_wrapper_view_model.dart';
import 'package:uremit/features/files/files_wrapper/presentation/widgets/files_wrapper_page_content.dart';

import '../../../../../app/globals.dart';
import '../../../../home/presentation/manager/home_view_model.dart';

class FilesWrapperPage extends StatefulWidget {
  const FilesWrapperPage({Key? key}) : super(key: key);

  @override
  State<FilesWrapperPage> createState() => _FilesWrapperPageState();
}

class _FilesWrapperPageState extends State<FilesWrapperPage> {
  final FilesWrapperViewModel _viewModel = sl();
  final HomeViewModel _viewModel2 = sl();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundGradient,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body: MultiProvider(
              providers: [
                ChangeNotifierProvider.value(value: _viewModel),
                ChangeNotifierProvider.value(value: _viewModel2),
              ],
              child: const FilesWrapperPageContent(),
            )),
      ),
    );
  }
}
