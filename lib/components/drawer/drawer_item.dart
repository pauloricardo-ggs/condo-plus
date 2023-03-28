
import 'package:condo_plus/theme/themes.dart';
import 'package:flutter/material.dart';

class DrawerItemList extends StatefulWidget {
  DrawerItemList({
    required this.items,
    required this.selectedIndex,
  });

  final List<DrawerItem> items;
  int selectedIndex;

  @override
  State<DrawerItemList> createState() => _DrawerItemListState();
}

class _DrawerItemListState extends State<DrawerItemList> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.items.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox.shrink();
            },
            itemBuilder: (BuildContext context, int index) {
              final isSelected = widget.selectedIndex == index;
              return GestureDetector(
                onTap: () async {
                  if (widget.selectedIndex != index) {
                    setState(() => widget.selectedIndex = index);
                    await Future.delayed(Duration(milliseconds: 200));
                    widget.items[index].onTap();
                  }
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(30.0)),
                        color: isSelected ? colorScheme.secondary : null,
                      ),
                      transform: Matrix4.translationValues(isSelected ? 0 : -30, 0, 0),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            width: isSelected ? 31 : 22,
                            height: isSelected ? 31 : 22,
                            child: LayoutBuilder(
                              builder: (BuildContext context, BoxConstraints constraints) {
                                final double iconSize = constraints.maxWidth;
                                return Icon(size: iconSize, widget.items[index].icon, color: Colors.white);
                              },
                            ),
                          ),
                          SizedBox(width: 15),
                          AnimatedDefaultTextStyle(
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            child: Text(widget.items[index].texto),
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: isSelected ? 21 : 15,
                              fontFamily: DefaultValues.fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class DrawerItem {
  const DrawerItem({
    required this.texto,
    required this.onTap,
    required this.icon,
  });

  final String texto;
  final VoidCallback onTap;
  final IconData icon;
}
