import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    Key? key,
    required this.name,
    this.noBackButton = false,
    this.actions,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  final String name;
  final bool noBackButton;
  final List<Widget>? actions;
  final Color? textColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).viewPadding.top,
          color: backgroundColor ?? Theme.of(context).backgroundColor,
        ),
        Container(
          height: 50,
          color: backgroundColor ?? Theme.of(context).backgroundColor,
          child: Material(
            type: MaterialType.transparency,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: textColor,
                      size: 30,
                    )),
                Expanded(
                  child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 25, color: textColor),
                  ),
                ),
                ...actions ?? []
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    // final offset = MediaQuery.of(context).viewPadding.top;
    return Size(0, 50);
  }
}
