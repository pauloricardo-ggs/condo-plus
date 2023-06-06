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
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        SkeletonLine(
          style: SkeletonLineStyle(
            height: 250,
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        Container(
          height: 75,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
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
