import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:uremit/features/cards/presentation/manager/cards_view_model.dart';
import 'package:uremit/features/dashboard/presentation/manager/dashboard_view_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../app/globals.dart';
import '../../../../../utils/router/uremit_router_delegate.dart';
import '../manager/receipt_screen_view_model.dart';

class WebViewContent extends StatefulWidget {
  WebViewContent({required this.url});
  final String url;
  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebViewContent> {
  bool loading = false;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    globalReceiptContext = context;
    super.initState();
  }

  @override
  void dispose() {
    globalReceiptContext = null;
    super.dispose();
  }

  int _stackToView = 1;

  void _handleLoad(String value) async {
    //imagaing this is poly
    Logger().v(value);
    ReceiptScreenViewModel receiptScreenViewModel = sl();
    var selectedMethod = receiptScreenViewModel.selectedPaymentMethod.value;
    if (selectedMethod!.id == 7) {
      if (value.contains('PoliStatus')) {
        setState(() {
          loading = true;
        });
        await Dio().get(value);
        String leftPart = value.split('?').first;
        String status = leftPart.split('/').last;
        receiptScreenViewModel.transactionStatus.value = status;
        getTransactions();
        getCardsList();
      }
    } else if (selectedMethod.id==11) {
      //http://uremit.ermispk.com/api/v1/TransactionStatus/GetPaymentStatus/Transact365Status?uid=&token=d005391b092b63cc9f6d6c00cfad6d7bae4231ced4620e94ae4a88b498a3316a&status=error
      if (value.contains(
          "Transact365Status")) {
        setState(() {
          loading = true;
        });
        await Dio().get(value);
        final url = Uri.parse(value);
        final status = url.queryParameters['status'];
        receiptScreenViewModel.transactionStatus.value = status!.toUpperCase();
        getTransactions();
        getCardsList();
      }
      Logger().v(value);
    }

    Logger().v(value);
    if (_stackToView == 1) {
      setState(() {
        _stackToView = 0;
      });
    }
  }

  getCardsList() {
    CardsViewModel cardsViewModel = sl();
    cardsViewModel.getAllCards(reCall: true);
  }

  getTransactions() {
    DashboardViewModel dashboardViewMode = sl();
    dashboardViewMode.getTransactionList();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text(
              'Payment',
              style: TextStyle(),
            ),
            toolbarHeight: 50.h,
          ),
          body: loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : IndexedStack(
                  index: _stackToView,
                  children: [
                    Column(
                      children: [
                        Expanded(
                            child: WebView(
                          initialUrl: widget.url,
                          javascriptMode: JavascriptMode.unrestricted,
                          onPageFinished: _handleLoad,
                          onWebViewCreated:
                              (WebViewController webViewController) {
                            _controller.complete(webViewController);
                          },
                        )),
                      ],
                    ),
                    const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ],
                )),
    );
  }
}
