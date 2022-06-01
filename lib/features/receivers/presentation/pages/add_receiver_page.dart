import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/globals.dart';
import 'package:uremit/features/receivers/presentation/widgets/pagination/add_reciever_info.dart';

import '../manager/receiver_view_model.dart';

class AddReceiver extends StatefulWidget {
  const AddReceiver({Key? key}) : super(key: key);

  @override
  State<AddReceiver> createState() => _AddReceiverState();
}

class _AddReceiverState extends State<AddReceiver> {
  final ReceiverViewModel _viewModel = sl();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: ChangeNotifierProvider.value(
        value: _viewModel,
        builder: (context, snapshot) {
          return const AddReceiverInfoContent();
        },
      ),
    );
  }
}
