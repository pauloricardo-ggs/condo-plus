import 'package:condo_plus/main.dart';
import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class AvisoButtonSkeletonList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: 4,
        itemBuilder: (context, index) => _AvisoButtonSkeleton(),
        separatorBuilder: (context, index) => const SizedBox(height: 15.0),
        padding: EdgeInsets.symmetric(vertical: 15.0),
      ),
    );
  }
}

class _AvisoButtonSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DefaultValues.borderRadius),
          ),
        ),
        SkeletonLine(
          style: SkeletonLineStyle(
            height: 250,
            borderRadius: BorderRadius.circular(DefaultValues.borderRadius),
          ),
        ),
        Container(
          height: 75,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
            color: themeManager.appColor.aviso_skeleton_header,
            borderRadius: BorderRadius.vertical(top: Radius.circular(DefaultValues.borderRadius)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SkeletonLine(
                style: SkeletonLineStyle(
                  borderRadius: BorderRadius.circular(30.0),
                  randomLength: true,
                  minLength: 150,
                  height: 20,
                ),
              ),
              SizedBox(height: 15.0),
              SkeletonLine(
                style: SkeletonLineStyle(
                  borderRadius: BorderRadius.circular(30.0),
                  width: 110,
                  height: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
