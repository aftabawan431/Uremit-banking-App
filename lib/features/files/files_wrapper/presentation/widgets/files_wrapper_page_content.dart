import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uremit/app/widgets/customs/custom_app_bar.dart';
import 'package:uremit/app/widgets/customs/tabview/custom_tab_view.dart';
import 'package:uremit/features/files/files_wrapper/presentation/manager/files_wrapper_view_model.dart';
import 'package:uremit/features/files/previous_files/presentation/pages/previous_files_page.dart';
import 'package:uremit/features/files/required_files/presentation/pages/required_files_page.dart';
import 'package:uremit/features/menu/account_wrapper/presentation/widgets/profile_header.dart';
import 'package:uremit/utils/extensions/extensions.dart';

class FilesWrapperPageContent extends StatefulWidget {
  const FilesWrapperPageContent({Key? key}) : super(key: key);

  @override
  _FilesWrapperPageContentState createState() => _FilesWrapperPageContentState();
}

class _FilesWrapperPageContentState extends State<FilesWrapperPageContent> {
  @override
  void initState() {
    context.read<FilesWrapperViewModel>().onErrorMessage = (value) => context.show(message: value.message, backgroundColor: value.backgroundColor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(title: 'Files'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProfileHeader(),
          SizedBox(height: 10.h),
          CustomTabView(
            key: context.read<FilesWrapperViewModel>().bottomNavigationKey,
            index: 0,
            height: 50.0,
            pages: const [
              PreviousFilesPage(),
              RequiredFilesPage()
            ],
            titles: const ['Previous Files', 'Required Files'],
            color: Colors.white,
            buttonBackgroundColor: Theme.of(context).indicatorColor,
            backgroundColor: Colors.transparent,
            animationCurve: Curves.easeInOut,
            letIndexChange: (index) => true,
          )
        ],
      ),
    );
  }
}
