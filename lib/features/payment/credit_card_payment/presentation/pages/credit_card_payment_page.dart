import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/payment/credit_card_payment/presentation/manager/credit_card_payment_view_model.dart';

import '../../../../../app/globals.dart';
import '../widgets/credit_card_payment_page_content.dart';

class CreditCardPaymentPage extends StatefulWidget {
  const CreditCardPaymentPage({Key? key}) : super(key: key);

  @override
  State<CreditCardPaymentPage> createState() => _CreditCardPaymentPageState();
}

class _CreditCardPaymentPageState extends State<CreditCardPaymentPage> {
  final CreditCardPaymentViewModel _viewModel = sl();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundGradient,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: ChangeNotifierProvider.value(
            value: _viewModel,
            builder: (context, snapshot) {
              return const CreditCardPaymentPageContent();
            },
          ),
        ),
      ),
    );
  }
}
