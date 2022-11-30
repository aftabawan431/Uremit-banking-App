import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants/app_level/app_assets.dart';

class DisplayStatusModel {
  final BuildContext context;

  final String title;
  final String content;
  final Function()? onDone;
  DisplayStatusModel(this.context,
      {required this.title, required this.content, this.onDone});

  show() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  SvgPicture.asset(AppAssets.uremitSvg),

                  SizedBox(
                    height: 20.h,
                  ),
                  if (title.isNotEmpty)
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 22.sp, fontWeight: FontWeight.bold),
                    ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                      ),
                      child: Text(
                        content,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black87,fontSize: 16.sp),
                      )),
                  SizedBox(
                    height: 30.h,
                  ),
                  const Divider(
                    color: Colors.black12,
                    height: 1,
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      if (false)
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Center(
                              child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.black26),
                          )),
                        )),
                      Container(
                        height: 50,
                        width: 1,
                        color: Colors.black12,
                      ),
                      Expanded(
                          child: InkWell(
                        onTap:onDone?? () {
                          Navigator.of(context).pop();
                        },
                        child: Center(
                            child: Text(
                          "Done",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        )),
                      )),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
