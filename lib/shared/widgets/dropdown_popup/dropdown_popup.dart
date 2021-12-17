import 'package:flutter/material.dart';
import 'package:flutter_basics_2/shared/widgets/dropdown_popup/dropdown_item.dart';
import 'package:flutter_basics_2/shared/widgets/offset_provider.dart';

class DropdownPopup<T> extends StatelessWidget {
  const DropdownPopup({
    required this.toBottom,
    required this.toRight,
    required this.rightOffset,
    required this.bottomOffset,
    required this.items,
    required this.offset,
    required this.parentOffset,
    required this.parentSize,
    Key? key,
  }) : super(key: key);

  final List<DropdownItem<T>> items;

  final bool toBottom;
  final bool toRight;
  final double rightOffset;
  final double bottomOffset;

  final Offset parentOffset;
  final Size parentSize;
  final int offset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DefaultTextStyle(
        style: TextStyle(
          color: Theme.of(context).colorScheme.background,
        ),
        child: Stack(
          children: [
            Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Positioned(
              top: toBottom ? parentOffset.dy + parentSize.height + offset : 0,
              left: toRight ? parentOffset.dx : 0,
              height:
                  toBottom ? bottomOffset - offset : parentOffset.dy - offset,
              width: toRight
                  ? rightOffset + parentSize.width
                  : parentOffset.dx + parentSize.width,
              child: Container(
                alignment: (() {
                  if (toBottom) {
                    if (toRight) return Alignment.topLeft;
                    return Alignment.topRight;
                  }
                  if (toRight) return Alignment.bottomLeft;
                  return Alignment.bottomRight;
                }()),
                child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onBackground,
                        borderRadius: BorderRadius.circular(10)),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        // key: listKey,
                        children: [
                          if (items.isNotEmpty)
                            ...items.map((e) => GestureDetector(
                                  child: Container(
                                      padding: const EdgeInsets.all(5),
                                      child: e.child),
                                  onTap: () {
                                    Navigator.pop(context, e.value);
                                  },
                                ))
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<T?> openDropdown<T>(
    BuildContext context, GlobalKey parentKey, List<DropdownItem<T>> items,
    [int? offset]) {
  final renderBox = parentKey.currentContext!.findRenderObject()! as RenderBox;

  double screenHeight = MediaQuery.of(context).size.height -
      OffsetProvider.of(context).offset.top -
      OffsetProvider.of(context).offset.bottom;
  Offset parentOffset = renderBox.localToGlobal(Offset.zero) -
      Offset(0, OffsetProvider.of(context).offset.top);
  Size parentSize = renderBox.size;

  double bottomOffset = screenHeight - parentOffset.dy - parentSize.height;
  double rightOffset =
      MediaQuery.of(context).size.width - parentOffset.dx - parentSize.width;

  bool toBottom = parentOffset.dy <= bottomOffset;
  bool toRight = rightOffset >= parentOffset.dx;

  return showDialog(
    barrierColor: Colors.transparent,
    context: context,
    builder: (context) {
      return DropdownPopup<T>(
          toBottom: toBottom,
          toRight: toRight,
          rightOffset: rightOffset,
          bottomOffset: bottomOffset,
          items: items,
          offset: offset ?? 0,
          parentOffset: parentOffset,
          parentSize: parentSize);
    },
  );
}
