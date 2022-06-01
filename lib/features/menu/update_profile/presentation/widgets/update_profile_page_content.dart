import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:uremit/features/menu/update_profile/presentation/widgets/pagination/address_details.dart';
import 'package:uremit/features/menu/update_profile/presentation/widgets/pagination/document_information.dart';
import 'package:uremit/features/menu/update_profile/presentation/widgets/pagination/personal_details.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../profile/presentation/manager/profile_view_model.dart';
import '../manager/update_profile_view_model.dart';

class UpdateProfilePageContent extends StatefulWidget {
  const UpdateProfilePageContent({Key? key}) : super(key: key);

  @override
  _UpdateProfilePageContentState createState() => _UpdateProfilePageContentState();
}

class _UpdateProfilePageContentState extends State<UpdateProfilePageContent> {
  @override
  void initState() {
    context.read<UpdateProfileViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<bool>(
          valueListenable: context.read<UpdateProfileViewModel>().isLoadingNotifier,
          builder: (_, value, __) {
            if (value) {
              return Center(
                child: CircularProgressIndicator.adaptive(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                ),
              );
            }
            if (context.read<ProfileViewModel>().profileDetails == null) {
              return Center(child: Text('Something Went Wrong!', style: Theme.of(context).textTheme.caption));
            }
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ExpandablePageView(
                      controller: context.read<UpdateProfileViewModel>().pageController,
                      physics: const BouncingScrollPhysics(),
                      animationDuration: const Duration(milliseconds: 500),
                      animateFirstPage: true,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: context.read<UpdateProfileViewModel>().onPageChange,
                      children: const [
                        PersonalDetails(),
                        AddressDetails(),
                        DocumentInformation(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                  child: SmoothPageIndicator(
                    controller: context.read<UpdateProfileViewModel>().pageController,
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
