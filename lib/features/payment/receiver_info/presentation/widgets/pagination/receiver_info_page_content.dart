import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:uremit/features/payment/receiver_info/presentation/widgets/pagination/receive_info.dart';
import 'package:uremit/features/payment/receiver_info/presentation/widgets/pagination/receiver_bank_info_page_content.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../manager/receiver_info_view_model.dart';

class ReceiverInfoPageContent extends StatefulWidget {
  const ReceiverInfoPageContent({Key? key}) : super(key: key);

  @override
  _ReceiverInfoPageContentState createState() =>
      _ReceiverInfoPageContentState();
}

class _ReceiverInfoPageContentState extends State<ReceiverInfoPageContent> {
  @override
  void initState() {
    context.read<ReceiverInfoViewModel>().onErrorMessage = (value) => context
        .show(message: value.message, backgroundColor: value.backgroundColor);
    super.initState();
    context.read<ReceiverInfoViewModel>().status.value = false;
    context.read<ReceiverInfoViewModel>().clearAddReceiverInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<bool>(
          valueListenable: context
              .read<ReceiverInfoViewModel>()
              .receiverInfoViewModel
              .isLoadingNotifier,
          builder: (_, value, __) {
            if (value) {
              return Center(
                child: CircularProgressIndicator.adaptive(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              );
            }
            // if (context.read<ReceiverInfoViewModel>().getBankListResponseModelBody == null) {
            //   return Center(child: Text('Something Went Wrong!', style: Theme.of(context).textTheme.caption));
            // }
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ExpandablePageView(
                      controller:
                          context.read<ReceiverInfoViewModel>().pageController,
                      physics: const BouncingScrollPhysics(),
                      animationDuration: const Duration(milliseconds: 500),
                      animateFirstPage: true,
                      scrollDirection: Axis.horizontal,
                      onPageChanged:
                          context.read<ReceiverInfoViewModel>().onPageChange,
                      children: const [

                        ReceiverInfo(),
                        ReceiverBankInfo(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                  child: SmoothPageIndicator(
                    controller:
                        context.read<ReceiverInfoViewModel>().pageController,
                    count: 2,
                    effect: ScrollingDotsEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: Theme.of(context).primaryColor,
                      dotColor: Colors.grey,
                      fixedCenter: true,
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
