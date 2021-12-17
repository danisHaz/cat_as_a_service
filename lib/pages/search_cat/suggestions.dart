import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basics_2/shared/widgets/top_offset_provider.dart';

class Suggestions extends StatelessWidget {
  const Suggestions(
      {Key? key,
      required this.parentKey,
      required this.options,
      required this.input,
      required this.selectOption})
      : super(key: key);

  final List<String> options;
  final GlobalKey parentKey;
  final String input;
  final Function(String) selectOption;

  List<String> _getSuggestions() {
    return options
        .where((tag) => tag.toLowerCase().contains(input.toLowerCase()))
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    final renderBox =
        parentKey.currentContext!.findRenderObject()! as RenderBox;
    final parenOffset = renderBox.localToGlobal(Offset.zero) -
        Offset(0, TopOffsetProvider.of(context).offset.top);
    final parenSize = renderBox.size;
    return Positioned(
        top: parenOffset.dy + parenSize.height + 5,
        left: parenOffset.dx,
        width: parenSize.width,
        child: Container(
          constraints: const BoxConstraints(maxHeight: 300),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.black),
          width: 100,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ..._getSuggestions().map((e) => GestureDetector(
                      onTap: () {
                        selectOption(e);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          e,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    )),
                if (_getSuggestions().isEmpty)
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "suggestions.no_suggestions".tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}
