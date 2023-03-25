import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class MoradorButtonSkeletonList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: 4,
        itemBuilder: (context, index) => MoradorButtonSkeleton(),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
    );
  }
}

class MoradorButtonSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DefaultValues.moradorButtonBorderRadius),
        color: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.05),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
        child: Row(
          children: [
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: 40,
                height: 40,
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 17.0),
                child: SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 20,
                    randomLength: true,
                    minLength: 100,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            SkeletonLine(
              style: SkeletonLineStyle(
                height: 26,
                width: 26,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            SizedBox(width: 3),
          ],
        ),
      ),
    );
  }
}
