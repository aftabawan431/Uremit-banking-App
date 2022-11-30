import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';

import '../../../../app/globals.dart';
import '../widgets/receiver_page_content.dart';

class ReceiverPage extends StatefulWidget {
  const ReceiverPage({Key? key}) : super(key: key);

  @override
  State<ReceiverPage> createState() => _ReceiverPageState();
}

class _ReceiverPageState extends State<ReceiverPage> with AutomaticKeepAliveClientMixin {
  final ReceiverViewModel _viewModel = sl();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: ChangeNotifierProvider.value(
        value: _viewModel,
        builder: (context, snapshot) {
          return const ReceiverPageContent();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
