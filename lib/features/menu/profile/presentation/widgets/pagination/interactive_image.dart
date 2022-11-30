import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../app/widgets/customs/custom_app_bar.dart';
import '../../../../../../utils/globals/app_globals.dart';

class InteractiveImage extends StatelessWidget {
  const InteractiveImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: '', ),
      body: Container(
          color: Colors.white,
          child: Center(
              child: Hero(
                  tag: heroImage,
                  child: CachedNetworkImage(
                    imageUrl: heroImage,
                  )))),
    );
  }
}
