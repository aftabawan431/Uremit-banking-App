import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:uremit/features/menu/account_wrapper/presentation/widgets/account_wrapper_page_content.dart';
import 'package:uremit/utils/constants/app_level/app_assets.dart';
import 'package:uremit/utils/extensions/extensions.dart';

import '../../../../../utils/globals/app_globals.dart';
import '../../../../menu/documents/presentation/manager/documents_view_model.dart';
import '../manager/required_file_view_model.dart';

class RequiredFilesPageContent extends StatefulWidget {
  const RequiredFilesPageContent({Key? key}) : super(key: key);

  @override
  _RequiredFilesPageContentState createState() => _RequiredFilesPageContentState();
}

class _RequiredFilesPageContentState extends State<RequiredFilesPageContent> {
  @override
  void initState() {
    context.read<RequiredFilesViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
    context.read<RequiredFilesViewModel>().getRequiredFiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 16.h),
        child: ValueListenableBuilder<bool>(
            valueListenable: context.read<RequiredFilesViewModel>().isLoadingNotifier,
            builder: (_, value, __) {
              if (value) {
                return Center(
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                  ),
                );
              }
              if (context.read<RequiredFilesViewModel>().requiredFileResponseModel == null) {
                return Center(child: Text('Something Went Wrong!', style: Theme.of(context).textTheme.caption));
              }
              if (context.read<RequiredFilesViewModel>().requiredFilesListNotifier.value.isEmpty) {
                return Center(
                  child: Text('No required file found', style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.black)),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Required Files', style: Theme.of(context).textTheme.headline6),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: ListView.separated(
                      itemCount: context.read<RequiredFilesViewModel>().requiredFileResponseModel!.getProfileRequestBody.length,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(thickness: 1.5, color: Theme.of(context).primaryColor);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return ExpansionTileCard(
                          baseColor: Colors.white,
                          expandedColor: Colors.white,
                          leading: SvgPicture.asset(AppAssets.icFolderSvg),
                          title: Text(context.read<RequiredFilesViewModel>().requiredFileResponseModel!.getProfileRequestBody[index].documentType,
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
                                        detail: context.read<RequiredFilesViewModel>().requiredFileResponseModel!.getProfileRequestBody[index].frontFileName),
                                    const Divider(),
                                    _detailItem(
                                        context: context,
                                        title: 'Date',
                                        detail: context.read<RequiredFilesViewModel>().requiredFileResponseModel!.getProfileRequestBody[index].createdDate),
                                    const Divider(),
                                    _detailItem(
                                        context: context,
                                        title: 'Document Type',
                                        detail: context.read<RequiredFilesViewModel>().requiredFileResponseModel!.getProfileRequestBody[index].documentType),
                                    // const Divider(),
                                    // _detailItem(
                                    //     context: context,
                                    //     title: 'Remarks',
                                    //     detail: context.read<RequiredFilesViewModel>().requiredFileResponseModel!.getProfileRequestBody[index].remarks),
                                    // const Divider(),
                                    // _detailItem(
                                    //     context: context,
                                    //     title: 'Asked By',
                                    //     detail: context.read<RequiredFilesViewModel>().requiredFileResponseModel!.getProfileRequestBody[index].remarks),
                                    const Divider(),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('File', style: Theme.of(context).textTheme.bodyText2),
                                        const Spacer(),
                                        SvgPicture.asset(AppAssets.icViewFileSvg),
                                        SizedBox(width: 5.w),
                                        GestureDetector(
                                          onTap: () {
                                            requiredDocId = context.read<RequiredFilesViewModel>().requiredFileResponseModel!.getProfileRequestBody[index].id;
                                            requiredDocAttachmentId = context.read<RequiredFilesViewModel>().requiredFileResponseModel!.getProfileRequestBody[index].documentTypeId;
                                            context.read<DocumentsViewModel>().documentTypeController.text =
                                                context.read<RequiredFilesViewModel>().requiredFileResponseModel!.getProfileRequestBody[index].documentType;
                                            changeIndex = 3;
                                            context.read<RequiredFilesViewModel>().moveToDocRequiredPage();
                                          },
                                          child: SimpleShadow(
                                            opacity: 0.6,
                                            color: Colors.black12,
                                            offset: const Offset(0, 0),
                                            sigma: 4,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 3.h),
                                              decoration: const ShapeDecoration(shape: StadiumBorder(), color: Colors.orange),
                                              child: Text('Upload', style: Theme.of(context).textTheme.caption?.copyWith(color: Theme.of(context).primaryColor)),
                                            ),
                                          ),
                                        )
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
