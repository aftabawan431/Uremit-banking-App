import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uremit/features/dashboard/presentation/manager/dashboard_view_model.dart';
import 'package:uremit/utils/constants/app_level/app_url.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.read<DashboardViewModel>().promotionList == null) {
      Container(
        height: 140.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(12.r),
        ),
      );
    }

    return CarouselSlider.builder(
      itemCount: context.read<DashboardViewModel>().promotionList?.promotionListBody.length ?? 0,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12.r),
            image: DecorationImage(
                image: CachedNetworkImageProvider(AppUrl.fileBaseUrl + context.read<DashboardViewModel>().promotionList!.promotionListBody[index].fileName),
                alignment: Alignment.center,
                fit: BoxFit.cover),
          ),
        );
      },
      options: CarouselOptions(
        height: 140.h,
        aspectRatio: 16 / 9,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
