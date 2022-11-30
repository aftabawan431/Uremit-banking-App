import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:uremit/features/files/previous_files/presentation/manager/previous_files_view_model.dart';
import 'package:uremit/utils/constants/app_level/app_assets.dart';
import 'package:uremit/utils/constants/app_level/app_url.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../../../utils/globals/app_globals.dart';

class PreviousFilesPageContent extends StatefulWidget {
  const PreviousFilesPageContent({Key? key}) : super(key: key);

  @override
  _PreviousFilesPageContentState createState() => _PreviousFilesPageContentState();
}

class _PreviousFilesPageContentState extends State<PreviousFilesPageContent> {
  @override
  void initState() {
    context.read<PreviousFilesViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
    context.read<PreviousFilesViewModel>().getPreviousFiles();
    super.initState();
  }

  late String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
        child: ValueListenableBuilder<bool>(
            valueListenable: context.read<PreviousFilesViewModel>().isLoadingNotifier,
            builder: (_, value, __) {
              if (value) {
                return Center(
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  ),
                );
              }
              if (context.read<PreviousFilesViewModel>().previousFileResponseModel == null) {
                return Center(child: Text('Something Went Wrong!', style: Theme.of(context).textTheme.caption));
              }
              if (context.read<PreviousFilesViewModel>().previousFilesListNotifier.value.isEmpty) {
                return Center(
                  child: Text('No previous file found', style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.black)),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Previous Files', style: Theme.of(context).textTheme.headline6),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: ListView.separated(
                      itemCount: context.read<PreviousFilesViewModel>().previousFileResponseModel!.previousFileBody.length,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(thickness: 1.5, color: Theme.of(context).primaryColor);
                      },
                      itemBuilder: (BuildContext context, int index) {

                        final file=context.read<PreviousFilesViewModel>().previousFileResponseModel!.previousFileBody[index];
                        return ExpansionTileCard(
                          baseColor: Colors.white,
                          expandedColor: Colors.white,
                          leading: SvgPicture.asset(AppAssets.icFolderSvg),
                          title: Text(file.documentType,
                              style: Theme.of(context).textTheme.subtitle2),
                          trailing: const Icon(Icons.expand_more, color: Color(0xFF818492)),
                          animateTrailing: true,
                          expandedTextColor: Theme.of(context).primaryColor,
                          contentPadding: EdgeInsets.zero,
                          elevation: 0,
                          duration: const Duration(milliseconds: 300),
                          children: [
                            SimpleShadow(
                              opacity: 0.6,
                              color: Colors.black12,
                              offset: const Offset(0, 0),
                              sigma: 10,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF7FCFF),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: const Color(0xFFD6D6D6),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    _detailItem(
                                        context: context,
                                        title: 'File Name',
                                        detail: file.frontFileName),
                                    const Divider(),
                                    _detailItem(
                                        context: context,
                                        title: 'Date',
                                        detail: file.createdDate),
                                    const Divider(),
                                    _detailItem(
                                        context: context,
                                        title: 'Document Type',
                                        detail: file.documentType),
                                    const Divider(),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('File', style: Theme.of(context).textTheme.bodyText2),
                                        const Spacer(),
                                        SvgPicture.asset(AppAssets.icViewFileSvg),
                                        SizedBox(width: 5.w),
                                        if(file.frontPath.isNotEmpty&&file.backPath.isEmpty)
                                        GestureDetector(
                                          onTap: () {
                                            if (file.frontPath.isEmpty) {
                                              return;
                                            }
                                            heroImage = AppUrl.fileBaseUrl + file.frontPath;
                                            context.read<PreviousFilesViewModel>().moveToHeroImage();
                                          },
                                          child: SimpleShadow(
                                            opacity: 0.6,
                                            color: Colors.black12,
                                            offset: const Offset(0, 0),
                                            sigma: 4,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 3.h),
                                              decoration: const ShapeDecoration(shape: StadiumBorder(), color: Colors.orange),
                                              child: Text('View', style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).primaryColor)),
                                            ),
                                          ),
                                        ), if(file.frontPath.isNotEmpty&&file.backPath.isNotEmpty)
                                        GestureDetector(
                                          onTap: () {
                                            if (file.frontPath.isEmpty) {
                                              return;
                                            }
                                            heroImage = AppUrl.fileBaseUrl + file.frontPath;
                                            context.read<PreviousFilesViewModel>().moveToHeroImage();
                                          },
                                          child: SimpleShadow(
                                            opacity: 0.6,
                                            color: Colors.black12,
                                            offset: const Offset(0, 0),
                                            sigma: 4,

                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 3.h),
                                              decoration: const ShapeDecoration(shape: StadiumBorder(), color: Colors.orange),
                                              child: Text('Front', style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).primaryColor)),
                                            ),
                                          ),
                                        ), if(file.frontPath.isNotEmpty&&file.backPath.isNotEmpty)
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: GestureDetector(
                                            onTap: () {
                                              if (file.backPath.isEmpty) {
                                                return;
                                              }
                                              heroImage = AppUrl.fileBaseUrl + file.backPath;
                                              context.read<PreviousFilesViewModel>().moveToHeroImage();
                                            },
                                            child: SimpleShadow(
                                              opacity: 0.6,
                                              color: Colors.black12,
                                              offset: const Offset(0, 0),
                                              sigma: 4,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 3.h),
                                                decoration: const ShapeDecoration(shape: StadiumBorder(), color: Colors.orange),
                                                child: Text('Back', style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).primaryColor)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget _detailItem({required BuildContext context, required String title, required String detail}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodyText2),
        SizedBox(width: 5.w),
        Expanded(
          child: Text(detail,
              maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).primaryColor), textAlign: TextAlign.end),
        ),
      ],
    );
  }
}
