import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/payment/receiver_info/presentation/widgets/pagination/receiver_info_page_content.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';

import '../../../../../app/globals.dart';
import '../../../../authentication/rates/presentation/manager/rates_view_model.dart';
import '../manager/receiver_info_view_model.dart';

class ReceiverInfoPage extends StatefulWidget {
  const ReceiverInfoPage({Key? key}) : super(key: key);

  @override
  State<ReceiverInfoPage> createState() => _ReceiverInfoPageState();
}

class _ReceiverInfoPageState extends State<ReceiverInfoPage> {
  final ReceiverInfoViewModel _viewModel = sl();
  final ReceiverViewModel _receiverViewModel = sl();
  final RatesViewModel ratesViewModel = sl();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundGradient,
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: MultiProvider(providers: [
              ChangeNotifierProvider.value(value: _viewModel),
              ChangeNotifierProvider.value(value: _receiverViewModel),
              ChangeNotifierProvider.value(value: ratesViewModel),
            ], child: const ReceiverInfoPageContent())),
      ),
    );
  }
}
