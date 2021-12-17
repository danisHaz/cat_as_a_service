import 'package:flutter/cupertino.dart';

class OffsetProvider extends InheritedWidget {
  OffsetProvider({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child) {
    // offset = PageOffset(top: MediaQuery.of(context).viewPadding.top);
  }

  late PageOffset offset;

  static OffsetProvider of(BuildContext context) {
    final OffsetProvider? result =
        context.dependOnInheritedWidgetOfExactType<OffsetProvider>();
    assert(result != null, 'No FrogColor found in context');
    return result!;
  }

  setOffset(BuildContext context) {
    offset = PageOffset(
        top: MediaQuery.of(context).viewPadding.top,
        bottom: MediaQuery.of(context).viewPadding.top);
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class PageOffset {
  double top;
  double bottom;

  PageOffset({
    required this.top,
    required this.bottom,
  });
}
