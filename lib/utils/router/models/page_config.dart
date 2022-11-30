import 'package:uremit/utils/router/models/page_keys.dart';
import 'package:uremit/utils/router/models/page_paths.dart';
import 'package:uremit/utils/router/pages.dart';

class PageConfigs {
  static PageConfiguration splashPageConfig = const PageConfiguration(key: PageKeys.splashPageKey, path: PagePaths.splashPagePath, uiPage: Pages.splashPage);
  static PageConfiguration authWrapperPageConfig = const PageConfiguration(key: PageKeys.authWrapperPageKey, path: PagePaths.authWrapperPagePath, uiPage: Pages.authWrapperPage);
  static PageConfiguration otpPageConfig = const PageConfiguration(key: PageKeys.otpPageKey, path: PagePaths.otpPagePath, uiPage: Pages.otpPage);
  static PageConfiguration getEmailPageConfig = const PageConfiguration(key: PageKeys.getEmailPageKey, path: PagePaths.getEmailPagePath, uiPage: Pages.getEmailPage);
  static PageConfiguration forgotOtpPageConfig = const PageConfiguration(key: PageKeys.forgotOtpPageKey, path: PagePaths.forgotOtpPagePath, uiPage: Pages.forgotOtpPage);
  static PageConfiguration resetForgotPasswordPageConfig =
      const PageConfiguration(key: PageKeys.resetForgotPasswordPageKey, path: PagePaths.resetForgotPasswordPagePath, uiPage: Pages.resetForgotPasswordPage);
  static PageConfiguration homePageConfig = const PageConfiguration(key: PageKeys.homePageKey, path: PagePaths.homePagePath, uiPage: Pages.homePage);
  static PageConfiguration dashboardPageConfig = const PageConfiguration(key: PageKeys.dashboardPageKey, path: PagePaths.dashboardPagePath, uiPage: Pages.dashboardPage);
  static PageConfiguration accountWrapperPageConfig =
      const PageConfiguration(key: PageKeys.accountWrapperPageKey, path: PagePaths.accountWrapperPagePath, uiPage: Pages.accountWrapperPage);
  static PageConfiguration filesWrapperPageConfig =
      const PageConfiguration(key: PageKeys.filesWrapperPageKey, path: PagePaths.filesWrapperPagePath, uiPage: Pages.filesWrapperPage);
  static PageConfiguration payIdInfoPageConfig = const PageConfiguration(key: PageKeys.payIdInfoPageKey, path: PagePaths.payIdInfoPagePath, uiPage: Pages.payIdInfoPage);
  static PageConfiguration payIdUploadPageConfig =
      const PageConfiguration(key: PageKeys.payIdUploadPageKey, path: PagePaths.payIdUploadPagePath, uiPage: Pages.payIdUploadDocuments);
  static PageConfiguration paymentWrapperPageConfig =
      const PageConfiguration(key: PageKeys.paymentWrapperPageKey, path: PagePaths.paymentWrapperPagePath, uiPage: Pages.paymentWrapper);
  static PageConfiguration poliPaymentPageConfig = const PageConfiguration(key: PageKeys.poliPaymentPageKey, path: PagePaths.poliPaymentPagePath, uiPage: Pages.poliPaymentPage);
  static PageConfiguration creditCardPaymentPageConfig =
      const PageConfiguration(key: PageKeys.creditCardPaymentPageKey, path: PagePaths.creditCardPaymentPagePath, uiPage: Pages.creditCardPaymentPage);
  static PageConfiguration receiptScreenPageConfig =
      const PageConfiguration(key: PageKeys.receiptScreenPaymentPageKey, path: PagePaths.receiptScreenPagePath, uiPage: Pages.receiptScreen);

  static PageConfiguration addReceiverPageConfig =
      const PageConfiguration(key: PageKeys.addReceiverInfoScreenPageKey, path: PagePaths.addReceiverInfoPagePath, uiPage: Pages.addReceiverInfo);

  static PageConfiguration interactiveHeroPageScreenPageConfig =
      const PageConfiguration(key: PageKeys.interactiveHeroPageScreenPageKey, path: PagePaths.interactiveHeroPageScreenPagePath, uiPage: Pages.interactiveHeroPageScreen);
  static PageConfiguration summaryDetailsScreenPageConfig =
      const PageConfiguration(key: PageKeys.summaryDetailsScreenPageKey, path: PagePaths.summaryDetailsScreenPagePath, uiPage: Pages.summaryDetailsScreen);
  static PageConfiguration webViewPageConfig = const PageConfiguration(key: PageKeys.webViewPageKey, path: PagePaths.webViewPagePath, uiPage: Pages.webViewPage);
}
