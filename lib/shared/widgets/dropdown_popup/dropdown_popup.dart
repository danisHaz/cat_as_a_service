import 'package:flutter/material.dart';
import 'package:flutter_basics_2/shared/widgets/dropdown_popup/dropdown_item.dart';
import 'package:flutter_basics_2/shared/widgets/offset_provider.dart';

class DropdownPopup<T> extends StatefulWidget {
  const DropdownPopup({
    Key? key,
    required this.parentOffset,
    required this.parentSize,
    required this.items,
    required this.screenHeight,
    required this.offset,
  }) : super(key: key);
  final Offset parentOffset;
  final Size parentSize;
  final int offset;
  final List<DropdownItem<T>> items;
  final double screenHeight;

  @override
  _DropdownPopupState createState() => _DropdownPopupState();
}

class _DropdownPopupState extends State<DropdownPopup> {
  bool visible = false;
  late bool toBottom;
  late bool toRight;
  late double rightOffset;
  late double bottomOffset;

  late bool contrastColors;
  final listKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    bottomOffset =
        widget.screenHeight - widget.parentOffset.dy - widget.parentSize.height;
    rightOffset = MediaQuery.of(context).size.width -
        widget.parentOffset.dx -
        widget.parentSize.width;

    toBottom = widget.parentOffset.dy <= bottomOffset;
    toRight = rightOffset >= widget.parentOffset.dx;
  }

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
              top: toBottom
                  ? widget.parentOffset.dy +
                      widget.parentSize.height +
                      widget.offset
                  : 0,
              left: toRight ? widget.parentOffset.dx : 0,
              height: toBottom
                  ? bottomOffset - widget.offset
                  : widget.parentOffset.dy - widget.offset,
              width: toRight
                  ? rightOffset + widget.parentSize.width
                  : widget.parentOffset.dx + widget.parentSize.width,
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
                        key: listKey,
                        children: [
                          if (widget.items.isNotEmpty)
                            ...widget.items.map((e) => GestureDetector(
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

  return showDialog(
    barrierColor: Colors.transparent,
    context: context,
    builder: (context) {
      return DropdownPopup<T>(
          offset: offset ?? 0,
          screenHeight: MediaQuery.of(context).size.height -
              OffsetProvider.of(context).offset.top -
              OffsetProvider.of(context).offset.bottom,
          parentOffset: renderBox.localToGlobal(Offset.zero) -
              Offset(0, OffsetProvider.of(context).offset.top),
          parentSize: renderBox.size,
          items: items);
    },
  );
}
