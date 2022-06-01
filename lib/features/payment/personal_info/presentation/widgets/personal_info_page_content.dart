import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:uremit/features/payment/personal_info/presentation/widgets/pagination/address_details.dart';
import 'package:uremit/features/payment/personal_info/presentation/widgets/pagination/document_information.dart';
import 'package:uremit/features/payment/personal_info/presentation/widgets/pagination/personal_details.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../manager/personal_info_view_model.dart';

class ProfileInfoPageContent extends StatefulWidget {
  const ProfileInfoPageContent({Key? key}) : super(key: key);

  @override
  _ProfileInfoPageContentState createState() => _ProfileInfoPageContentState();
}

class _ProfileInfoPageContentState extends State<ProfileInfoPageContent> {
  @override
  void initState() {
    context.read<ProfileInfoViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<bool>(
          valueListenable: context.read<ProfileInfoViewModel>().profileInfoViewModel.isLoadingNotifier,
          builder: (_, value, __) {
            if (value) {
              return Center(
                child: CircularProgressIndicator.adaptive(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                ),
              );
            }
            // if (context.read<ProfileInfoViewModel>().profileViewModel.profileDetails == null) {
            //   return Center(child: Text('Something Went Wrong!', style: Theme.of(context).textTheme.caption));
            // }
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ExpandablePageView(
                      controller: context.read<ProfileInfoViewModel>().pageController,
                      physics: const BouncingScrollPhysics(),
                      animationDuration: const Duration(milliseconds: 500),
                      animateFirstPage: true,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: context.read<ProfileInfoViewModel>().onPageChange,
                      children: const [
                        PersonalInfoDetails(),
                        PersonalAddressDetails(),
                        PersonalInfoDocumentInformation(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                  child: SmoothPageIndicator(
                    controller: context.read<ProfileInfoViewModel>().pageController,
                    count: 3,
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
