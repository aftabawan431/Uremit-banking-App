import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/home/presentation/manager/home_view_model.dart';
import 'package:uremit/features/payment/receiver_info/presentation/manager/receiver_info_view_model.dart';
import 'package:uremit/features/receivers/presentation/manager/receiver_view_model.dart';

import '../../../../../app/globals.dart';
import '../manager/payment_details_view_model.dart';
import '../widgets/payment_details_page_content.dart';

class PaymentDetailsPage extends StatefulWidget {
  const PaymentDetailsPage({Key? key}) : super(key: key);

  @override
  State<PaymentDetailsPage> createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPage> {
  final PaymentDetailsViewModel _viewModel = sl();
  final HomeViewModel _homeViewModel=sl();
  final ReceiverViewModel _receiverViewModel=sl();
  final ReceiverInfoViewModel receiverInfoViewModel=sl();

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
                ChangeNotifierProvider.value(value: _homeViewModel),
                ChangeNotifierProvider.value(value: _receiverViewModel),
                ChangeNotifierProvider.value(value: receiverInfoViewModel),
              ],
              child: const PaymentDetailsPageContent())
        ),
      ),
    );
  }
}
