import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_basics_2/utils/system_chrome.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    Key? key,
    this.name = '',
    this.noBackButton = false,
    this.actions,
    this.backgroundColor,
    this.textColor,
    this.mainNavButton,
    this.onMainNavButtonPressed,
  }) : super(key: key);

  final String name;
  final bool noBackButton;
  final List<Widget>? actions;
  final Color? textColor;
  final Color? backgroundColor;
  final Icon? mainNavButton;
  final VoidCallback? onMainNavButtonPressed;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getUiStyle(Theme.of(context)),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).viewPadding.top,
            color: backgroundColor ?? Theme.of(context).colorScheme.background,
          ),
          Container(
            decoration: BoxDecoration(
              color: backgroundColor ?? Theme.of(context).colorScheme.background,
              // boxShadow: [
              //   BoxShadow(
              //     color: Theme.of(context).shadowColor.withOpacity(0.4),
              //     offset: Offset(0, 2),
              //     spreadRadius: 0,
              //     blurRadius: 1,
              //   ),
              // ],
            ),
            height: 50,
            child: Material(
              type: MaterialType.transparency,
              child: Row(
                children: [
                  IconButton(
                    onPressed: onMainNavButtonPressed == null
                        ? () {
                            Navigator.of(context).pop();
                          }
                        : onMainNavButtonPressed,
                    icon: mainNavButton ??
                        const Icon(
                          Icons.arrow_back_ios,
                          size: 30,
                        ),
                  ),
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
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    // final offset = MediaQuery.of(context).viewPadding.top;
    return const Size(0, 50);
  }
}
