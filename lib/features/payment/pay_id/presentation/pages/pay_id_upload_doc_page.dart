import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/payment/pay_id/presentation/manager/pay_id_view_model.dart';

import '../../../../../app/globals.dart';
import '../../../receipt_screen/presentation/manager/receipt_screen_view_model.dart';
import '../widgets/pay_id_upload_doc_page_content.dart';

class PayIdUploadDocumentsPage extends StatefulWidget {
  const PayIdUploadDocumentsPage({Key? key}) : super(key: key);

  @override
  State<PayIdUploadDocumentsPage> createState() =>
      _PayIdUploadDocumentsPageState();
}

class _PayIdUploadDocumentsPageState extends State<PayIdUploadDocumentsPage> {
  final PayIdInfoViewModel _viewModel = sl();
  final ReceiptScreenViewModel _screenViewModel = sl();

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
              ChangeNotifierProvider.value(value: _screenViewModel),
            ], child: const PayIdUploadDocumentsPageContent())),
      ),
    );
  }
}
