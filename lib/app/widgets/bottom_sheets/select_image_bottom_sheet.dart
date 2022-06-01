// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class SelectImageBottomSheet {
//   final BuildContext context;
//
//   SelectImageBottomSheet({required this.context});
//
//   Future show() {
//     return showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.r),
//       ),
//       builder: (BuildContext bottomSheetContext) {
//         return SafeArea(
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(topLeft: Radius.circular(15.r), topRight: Radius.circular(15.r)),
//             ),
//             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Select image',
//                       style: Theme.of(context).textTheme.headline6?.copyWith(color: Theme.of(context).primaryColor),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       icon: const Icon(
//                         Icons.cancel_rounded,
//                         color: Colors.redAccent,
//                         size: 26,
//                       ),
//                     )
//                   ],
//                 ),
//                 Wrap(
//                   children: <Widget>[
//                     ListTile(
//                       contentPadding: EdgeInsets.zero,
//                       leading: Icon(
//                         Icons.add_photo_alternate_rounded,
//                         color: Theme.of(context).iconTheme.color,
//                       ),
//                       title: const Text(
//                         'Gallery',
//                       ),
//                       onTap: () async {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                     ListTile(
//                       contentPadding: EdgeInsets.zero,
//                       leading: Icon(
//                         Icons.camera_enhance_rounded,
//                         color: Theme.of(context).iconTheme.color,
//                       ),
//                       title: const Text(
//                         'Camera',
//                       ),
//                       onTap: () async {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
