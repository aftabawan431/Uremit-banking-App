import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/payment/poli_payment/presentation/widgets/poli_payment_page_content.dart';

import '../../../../../app/globals.dart';
import '../manager/poli_payment_view_model.dart';

class PoliPaymentPage extends StatefulWidget {
  const PoliPaymentPage({Key? key}) : super(key: key);

  @override
  State<PoliPaymentPage> createState() => _PoliPaymentPageState();
}

class _PoliPaymentPageState extends State<PoliPaymentPage> {
  final PoliPaymentViewModel _viewModel = sl();

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
              return const PoliPaymentPageContent();
            },
          ),
        ),
      ),
    );
  }
}
