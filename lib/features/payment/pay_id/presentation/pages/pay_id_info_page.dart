import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/payment/pay_id/presentation/manager/pay_id_view_model.dart';
import 'package:uremit/features/payment/receipt_screen/presentation/manager/receipt_screen_view_model.dart';

import '../../../../../app/globals.dart';
import '../../../payment_details/presentation/manager/payment_details_view_model.dart';
import '../widgets/pay_id_info_page_content.dart';

class PayIdInfoPage extends StatefulWidget {
  const PayIdInfoPage({Key? key}) : super(key: key);

  @override
  State<PayIdInfoPage> createState() => _PayIdInfoPageState();
}

class _PayIdInfoPageState extends State<PayIdInfoPage> {
  final PayIdInfoViewModel _viewModel = sl();
  final ReceiptScreenViewModel _screenViewModel = sl();
  final PaymentDetailsViewModel paymentDetailsViewModel = sl();

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
              return MultiProvider(

                  providers: [
                    ChangeNotifierProvider.value(value: _viewModel),
                    ChangeNotifierProvider.value(value: _screenViewModel),
                    ChangeNotifierProvider.value(value: paymentDetailsViewModel),
                  ],
                  child: const PayIdInfoPageContent());
            },
          ),
        ),
      ),
    );
  }
}
