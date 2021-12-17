import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

class BaseErrorPage extends StatelessWidget {
  final String? errorMsg;
  const BaseErrorPage({Key? key, this.errorMsg}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMsg ?? "error_notify".tr()
      ),
    );
  }
}