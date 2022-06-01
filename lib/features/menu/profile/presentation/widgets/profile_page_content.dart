import 'dart:async';

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:uremit/features/menu/profile/presentation/manager/profile_view_model.dart';
import 'package:uremit/features/menu/profile/presentation/widgets/pagination/document_pagination.dart';
import 'package:uremit/features/menu/profile/presentation/widgets/pagination/personal_pagination.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../update_profile/presentation/manager/update_profile_view_model.dart';

class ProfilePageContent extends StatefulWidget {
  const ProfilePageContent({Key? key}) : super(key: key);

  @override
  _ProfilePageContentState createState() => _ProfilePageContentState();
}

class _ProfilePageContentState extends State<ProfilePageContent> {
  @override
  void initState() {
    context.read<ProfileViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);

    super.initState();
    getValues();
  }

  getValues() async {
    await context.read<ProfileViewModel>().getProfile();
    context.read<UpdateProfileViewModel>().loadProfileData(context.read<ProfileViewModel>().profileDetails);
    await context.read<UpdateProfileViewModel>().getCountries();
    Timer(const Duration(milliseconds: 400), () {
      context.read<UpdateProfileViewModel>().nationalityCountry = context
          .read<UpdateProfileViewModel>()
          .countriesList!
          .body
          .firstWhere((element) => element.countryId == context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.nationalityCountryID);
      context.read<UpdateProfileViewModel>().getCountryProvince(context.read<ProfileViewModel>().profileDetails!.ProfileDetailsBody.nationalityCountryID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<bool>(
        valueListenable: context.read<ProfileViewModel>().isLoadingNotifier,
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
                    controller: context.read<ProfileViewModel>().pageController,
                    physics: const BouncingScrollPhysics(),
                    animationDuration: const Duration(milliseconds: 500),
                    animateFirstPage: true,
                    scrollDirection: Axis.horizontal,
                    children: const [
                      PersonalPagination(),
                      DocumentPagination(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
                child: SmoothPageIndicator(
                  controller: context.read<ProfileViewModel>().pageController,
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
        },
      ),
    );
  }
}
