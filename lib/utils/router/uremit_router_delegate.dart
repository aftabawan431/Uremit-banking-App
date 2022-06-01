import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:uremit/features/authentication/auth_wrapper/presentation/pages/auth_wrapper_page.dart';
import 'package:uremit/features/authentication/forgot_password/presentation/pages/get_email_page.dart';
import 'package:uremit/features/authentication/otp/presentation/pages/otp_page.dart';
import 'package:uremit/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:uremit/features/files/files_wrapper/presentation/pages/files_wrapper_page.dart';
import 'package:uremit/features/home/presentation/pages/home_page.dart';
import 'package:uremit/features/menu/account_wrapper/presentation/pages/account_wrapper_page.dart';
import 'package:uremit/features/payment/credit_card_payment/presentation/pages/credit_card_payment_page.dart';
import 'package:uremit/features/payment/pay_id/presentation/pages/pay_id_info_page.dart';
import 'package:uremit/features/payment/pay_id/presentation/pages/pay_id_upload_doc_page.dart';
import 'package:uremit/features/payment/payment_wrapper/presentation/pages/payment_wrapper_page.dart';
import 'package:uremit/features/payment/poli_payment/presentation/pages/poli_payment_page.dart';
import 'package:uremit/features/payment/receipt_screen/presentation/pages/receipt_screen_page.dart';
import 'package:uremit/features/receivers/presentation/pages/add_receiver_page.dart';
import 'package:uremit/utils/extensions/extensions.dart';
import 'package:uremit/utils/router/models/page_paths.dart';

import '../../app/globals.dart';
import '../../features/authentication/forgot_password/presentation/pages/forgot_otp_page.dart';
import '../../features/authentication/forgot_password/presentation/pages/reset_password_page.dart';
import '../../features/home/presentation/manager/home_view_model.dart';
import '../../features/menu/profile/presentation/widgets/pagination/interactive_image.dart';
import '../../features/payment/receipt_screen/presentation/widgets/summary_details_screen_page_content.dart';
import '../../features/receivers/presentation/widgets/receiver_page_content.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../constants/enums/page_state_enum.dart';
import 'app_state.dart';
import 'pages.dart';

BuildContext?
    globalHomeContext; // doing this to pop the bottom sheet on home screen

class UremitRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  late final AppState appState;
  final List<Page> _pages = [];
  late BackButtonDispatcher backButtonDispatcher;

  List<MaterialPage> get pages => List.unmodifiable(_pages);

  UremitRouterDelegate(this.appState) {
    appState.addListener(() {
      notifyListeners();
    });
  }

  HomeViewModel get _homeViewModel => sl();

  @override
  Widget build(BuildContext context) {
    /// Faulty Code will need to find a way to solve it
    appState.globalErrorShow = (value) {
      context.show(message: value);
    };

    return Container(
      key: ValueKey(pages.last.name),
      child: Navigator(
        key: navigatorKeyGlobal,
        onPopPage: _onPopPage,
        pages: buildPages(),
      ),
    );
  }

  List<Page> buildPages() {
    switch (appState.currentAction.state) {
      case PageState.none:
        break;
      case PageState.addPage:
        addPage(appState.currentAction.page!);
        break;
      case PageState.remove:
        removePage(appState.currentAction.page!);
        break;

      case PageState.pop:
        pop();
        break;
      case PageState.addAll:
        // TODO: Handle this case.
        break;
      case PageState.addWidget:
        // TODO: Handle this case.
        break;
      case PageState.replace:
        replace(appState.currentAction.page!);
        break;
      case PageState.replaceAll:
        replaceAll(appState.currentAction.page!);
        break;
    }
    return List.of(_pages);
  }

  void replaceAll(PageConfiguration newRoute) {
    _pages.clear();
    setNewRoutePath(newRoute);
  }

  void replace(PageConfiguration newRoute) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    addPage(newRoute);
  }

  void removePage(PageConfiguration page) {
    if (_pages.isEmpty) {
      pages.remove(page);
    }
  }

  /// This method adds pages based on the PageConfig received
  /// [Input]: [PageConfiguration]
  void addPage(PageConfiguration pageConfig) {
    final shouldAddPage =
        _pages.isEmpty || (_pages.last.name != pageConfig.path);

    if (shouldAddPage) {
      switch (pageConfig.uiPage) {
        case Pages.splashPage:
          _addPageData(const SplashPage(), pageConfig);
          // _addPageData(const DashboardPage(), pageConfig);
          break;
        case Pages.authWrapperPage:
          _addPageData(const AuthWrapperPage(), pageConfig);
          break;
        case Pages.otpPage:
          _addPageData(const OtpPage(), pageConfig);
          break;
        case Pages.getEmailPage:
          _addPageData(const GetEmailPage(), pageConfig);
          break;
        case Pages.forgotOtpPage:
          _addPageData(const ForgotOtpPage(), pageConfig);
          break;
        case Pages.resetForgotPasswordPage:
          _addPageData(const ResetPasswordPage(), pageConfig);
          break;
        case Pages.homePage:
          _addPageData(const HomePage(), pageConfig);
          break;
        case Pages.dashboardPage:
          _addPageData(const DashboardPage(), pageConfig);
          break;
        case Pages.accountWrapperPage:
          _addPageData(const AccountWrapperPage(), pageConfig);
          break;
        case Pages.filesWrapperPage:
          _addPageData(const FilesWrapperPage(), pageConfig);
          break;
        case Pages.payIdInfoPage:
          _addPageData(const PayIdInfoPage(), pageConfig);
          break;
        case Pages.payIdUploadDocuments:
          _addPageData(const PayIdUploadDocumentsPage(), pageConfig);
          break;
        case Pages.paymentWrapper:
          _addPageData(const PaymentWrapperPage(), pageConfig);
          break;
        case Pages.poliPaymentPage:
          _addPageData(const PoliPaymentPage(), pageConfig);
          break;
        case Pages.creditCardPaymentPage:
          _addPageData(const CreditCardPaymentPage(), pageConfig);
          break;
        case Pages.receiptScreen:
          _addPageData(const ReceiptScreenPage(), pageConfig);
          break;
        case Pages.addReceiverInfo:
          _addPageData(const AddReceiver(), pageConfig);
          break;

        case Pages.interactiveHeroPageScreen:
          _addPageData(const InteractiveImage(), pageConfig);
          break;
        case Pages.summaryDetailsScreen:
          _addPageData(const SummaryDetailsScreenPageContent(), pageConfig);
          break;
      }
    }
  }

  void _addPageData(Widget child, PageConfiguration pageConfig) {
    _pages.add(
      _createPage(child, pageConfig),
    );
  }

  MaterialPage _createPage(Widget child, PageConfiguration pageConfig) {
    return MaterialPage(
        child: child,
        key: ValueKey(pageConfig.key),
        name: pageConfig.path,
        arguments: pageConfig);
  }

  bool _onPopPage(Route<dynamic> route, result) {
    final didPop = route.didPop(result);
    Logger().v(didPop);
    print('here we are');
    if (!didPop) {
      return false;
    }
    if (canPop()) {
      pop();
      return true;
    } else {
      return false;
    }
  }

  void pop() {
    if (globalHomeContext != null) {
      Navigator.of(globalHomeContext!).pop();
      globalHomeContext = null;
      return;
    }
    if (canPop()) {
      _removePage(_pages.last as MaterialPage);
    } else {
      if (_pages.last.name != PagePaths.authWrapperPagePath) {
        _homeViewModel.onBottomNavTap(0);
      }
    }
  }

  void _removePage(MaterialPage page) {
    _pages.remove(page);
    // notifyListeners();
  }

  bool canPop() {
    return _pages.length > 1;
  }

  @override
  Future<bool> popRoute() {
    Logger().i('Calling pop');

    if (canPop()) {
      _removePage(_pages.last as MaterialPage);
      return Future.value(true);
    }
    return Future.value(false);
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) {
    final shouldAddPage =
        _pages.isEmpty || (_pages.last.name != configuration.path);

    if (!shouldAddPage) {
      return SynchronousFuture(null);
    }
    _pages.clear();
    addPage(configuration);

    return SynchronousFuture(null);
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => navigatorKeyGlobal;
}
