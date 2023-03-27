import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/material.dart';

class CustomExpansionList extends StatefulWidget {
  final Duration duration;
  final Widget child;
  final String title;

  const CustomExpansionList({
    required this.duration,
    required this.child,
    required this.title,
  });

  @override
  State<CustomExpansionList> createState() => _CustomExpansionListState();
}

class _CustomExpansionListState extends State<CustomExpansionList> with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _isExpanded = false;
    _animationController = new AnimationController(vsync: this, duration: widget.duration, upperBound: 0.5);
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              setState(
                () {
                  _isExpanded ? _animationController.reverse(from: 0.5) : _animationController.forward(from: 0.0);
                  _isExpanded = !_isExpanded;
                },
              );
            },
            child: Container(
              color: AppColors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: DefaultValues.fontFamily),
                  ),
                  RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0).animate(_animationController),
                    child: Icon(Icons.expand_more, color: AppColors.white),
                  ),
                ],
              ),
            )),
        AnimatedSwitcher(
          duration: widget.duration,
          transitionBuilder: (Widget child, Animation<double> animation) => SizeTransition(child: child, sizeFactor: animation, axisAlignment: -1),
          child: _isExpanded ? widget.child : SizedBox(),
        ),
      ],
    );
  }
}
