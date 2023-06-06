import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ReservaButtonSkeletonList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: 4,
        itemBuilder: (context, index) {
          return _ReservaButtonSkeleton();
        },
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
    );
  }
}

class _ReservaButtonSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      constraints: BoxConstraints(minHeight: 43),
      child: Padding(
        padding: const EdgeInsets.only(top: 6.0, bottom: 6.0, left: 7.0, right: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SkeletonLine(
              style: SkeletonLineStyle(
                height: 26,
                width: 26,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 20,
                    minLength: 100,
                    randomLength: true,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            SkeletonLine(
              style: SkeletonLineStyle(
                height: 20,
                width: 83,
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
