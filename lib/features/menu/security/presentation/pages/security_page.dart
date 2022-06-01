import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/menu/security/presentation/manager/security_view_model.dart';

import '../../../../../app/globals.dart';
import '../widgets/security_page_content.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({Key? key}) : super(key: key);

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  final SecurityViewModel _viewModel = sl();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ChangeNotifierProvider.value(
          value: _viewModel,
          builder: (context, snapshot) {
            return const SecurityPageContent();
          },
        ),
      ),
    );
  }
}
