import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/cards/presentation/manager/cards_view_model.dart';
import 'package:uremit/features/payment/payment_details/presentation/manager/payment_details_view_model.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';

import '../../../../../app/globals.dart';
import '../manager/receipt_screen_view_model.dart';
import '../widgets/receipt_screen_page_content.dart';

class ReceiptScreenPage extends StatefulWidget {
  const ReceiptScreenPage({Key? key}) : super(key: key);

  @override
  State<ReceiptScreenPage> createState() => _ReceiptScreenPageState();
}

class _ReceiptScreenPageState extends State<ReceiptScreenPage> {
  final ReceiptScreenViewModel _viewModel = sl();
  final PaymentDetailsViewModel _paymentDetailsViewModel = sl();
  final ReceiverViewModel _receiverViewModal = sl();
  final CardsViewModel _cardsViewModel = sl();


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundGradient,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: MultiProvider(
              providers: [
                ChangeNotifierProvider.value(value: _viewModel),
                ChangeNotifierProvider.value(value: _paymentDetailsViewModel),
                ChangeNotifierProvider.value(value: _receiverViewModal),
                ChangeNotifierProvider.value(value: _cardsViewModel),
              ],
              child: const ReceiptScreenPageContent())
        ),
      ),
    );
  }
}
