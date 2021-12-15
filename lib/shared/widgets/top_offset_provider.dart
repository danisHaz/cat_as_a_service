import 'package:flutter/cupertino.dart';

class TopOffsetProvider extends InheritedWidget {
  TopOffsetProvider(
      {Key? key, required Widget child, required BuildContext context})
      : super(key: key, child: child) {
    offset = PageOffset(top: MediaQuery.of(context).viewPadding.top);
  }

  late final PageOffset offset;

  static TopOffsetProvider of(BuildContext context) {
    final TopOffsetProvider? result =
        context.dependOnInheritedWidgetOfExactType<TopOffsetProvider>();
    assert(result != null, 'No FrogColor found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class PageOffset {
  double top;
  PageOffset({
    required this.top,
  });
}
