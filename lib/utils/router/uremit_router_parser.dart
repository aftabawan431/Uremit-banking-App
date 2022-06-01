import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uremit/utils/router/models/page_paths.dart';
import 'package:uremit/utils/router/pages.dart';

import 'models/page_config.dart';

class UremitRouterParser extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(RouteInformation routeInformation) {
    final uri = Uri.parse(routeInformation.location ?? '');

    if (uri.pathSegments.isEmpty) {
      return SynchronousFuture(PageConfigs.splashPageConfig);
    }

    final path = '/' + uri.pathSegments[0];

    switch (path) {
      case PagePaths.splashPagePath:
        return SynchronousFuture(PageConfigs.splashPageConfig);
      case PagePaths.authWrapperPagePath:
        return SynchronousFuture(PageConfigs.authWrapperPageConfig);
      default:
        return SynchronousFuture(PageConfigs.splashPageConfig);
    }
  }

  @override
  RouteInformation restoreRouteInformation(PageConfiguration configuration) {
    switch (configuration.uiPage) {
      case Pages.splashPage:
        return const RouteInformation(location: PagePaths.splashPagePath);
      case Pages.authWrapperPage:
        return const RouteInformation(location: PagePaths.authWrapperPagePath);
      case Pages.otpPage:
        return const RouteInformation(location: PagePaths.otpPagePath);
      case Pages.getEmailPage:
        return const RouteInformation(location: PagePaths.getEmailPagePath);
      case Pages.forgotOtpPage:
        return const RouteInformation(location: PagePaths.forgotOtpPagePath);
      case Pages.resetForgotPasswordPage:
        return const RouteInformation(location: PagePaths.resetForgotPasswordPagePath);
      case Pages.homePage:
        return const RouteInformation(location: PagePaths.homePagePath);
      case Pages.dashboardPage:
        return const RouteInformation(location: PagePaths.dashboardPagePath);
      case Pages.accountWrapperPage:
        return const RouteInformation(location: PagePaths.accountWrapperPagePath);
      case Pages.filesWrapperPage:
        return const RouteInformation(location: PagePaths.filesWrapperPagePath);
      case Pages.payIdInfoPage:
        return const RouteInformation(location: PagePaths.payIdInfoPagePath);
      case Pages.payIdUploadDocuments:
        return const RouteInformation(location: PagePaths.payIdUploadPagePath);
      case Pages.paymentWrapper:
        return const RouteInformation(location: PagePaths.paymentWrapperPagePath);
      case Pages.poliPaymentPage:
        return const RouteInformation(location: PagePaths.poliPaymentPagePath);
      case Pages.creditCardPaymentPage:
        return const RouteInformation(location: PagePaths.creditCardPaymentPagePath);
      case Pages.receiptScreen:
        return const RouteInformation(location: PagePaths.receiptScreenPagePath);
      case Pages.addReceiverInfo:
        return const RouteInformation(location: PagePaths.addReceiverInfoPagePath);
      case Pages.interactiveHeroPageScreen:
        return const RouteInformation(location: PagePaths.creditCardPaymentPagePath);
      case Pages.addReceiverInfo:
        return const RouteInformation(location: PagePaths.addReceiverInfoPagePath);
      case Pages.summaryDetailsScreen:
        return const RouteInformation(location: PagePaths.addReceiverInfoPagePath);
    }
  }
}
