import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_basics_2/pages/add_cat/cat_editor.dart';
import 'package:flutter_basics_2/shared/cat.dart';
import 'package:flutter_basics_2/shared/widgets/action_buttons.dart';
import 'package:flutter_basics_2/shared/widgets/custom_appbar.dart';
import 'package:flutter_basics_2/shared/widgets/dropdown_popup/dropdown_item.dart';
import 'package:flutter_basics_2/shared/widgets/dropdown_popup/dropdown_popup.dart';
import 'package:flutter_basics_2/shared/widgets/offset_provider.dart';
import 'package:flutter_basics_2/utils/consts.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';

import '../api_test.dart';

class FakeWidget extends StatelessWidget {
  final items;
  const FakeWidget({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey key = GlobalKey();
    return Scaffold(
      body: Container(
        width: 800,
        height: 600,
        child: IconButton(
          key: key,
          icon: const Icon(FontAwesomeIcons.accessibleIcon),
          onPressed: () async {
            final func = await openDropdown(
              context,
              key,
              items,
            );
          },
        ),
      ),
    );
  }
}

void main() {
  group("Cat editor page widget testing", () {
    testWidgets("Every field must be filled if cat has info for this field",
        (WidgetTester tester) async {
      const txt = "los angeles kings";
      const color = "purple";
      const fontSize = 55.0;
      const filter = CatDecorationFilter.blur;
      const height = 300.0;
      const width = 250.0;
      final kitty = FakeCatRepository().getCatWithAdditionalParams(
        text: txt,
        textColor: color,
        fontSize: fontSize,
        filter: filter,
        height: height,
        width: width,
      );

      Logger().d("${kitty.height} ${kitty.width}");

      await tester.pumpWidget(MaterialApp(home: CatEditorPage(cat: kitty)));
      // await tester.pump();
      // await tester.pumpFrames(target, maxDuration)
      // print('$h')
      // final gesture = await tester.startGesture(Offset(30, 300)); //Position of the scrollview
      // await gesture.moveBy(Offset(0, -300)); //How much to scroll by
      // await gesture.up();
      final findHeightField = find.text("$height");
      final findWidthField = find.text("$width");
      final findTextField = find.text(txt);
      final findColorField = find.text(color);
      final findFontSizeField = find.text("$fontSize");
      final findFiltersField = find.text(filter.emptyIfNull());
      final listFinder = find.byType(Scrollable).first;

      await tester.pump();
      await tester.scrollUntilVisible(findHeightField, 500,
          scrollable: listFinder);
      await tester.pump();

      final fuck = find.byType(TextField);
      expect(findTextField, findsOneWidget);
      expect(findColorField, findsOneWidget);
      expect(findFontSizeField, findsOneWidget);
      expect(findHeightField, findsOneWidget);
      expect(findWidthField, findsOneWidget);
      expect(findFiltersField, findsOneWidget);
    });

    testWidgets(
        "Cat editor must have appbar with download and share action buttons",
        (WidgetTester tester) async {
      const txt = "los angeles kings";
      const color = "purple";
      const fontSize = 55.0;
      const filter = CatDecorationFilter.blur;
      const height = 300.0;
      const width = 250.0;
      final kitty = FakeCatRepository().getCatWithAdditionalParams(
        text: txt,
        textColor: color,
        fontSize: fontSize,
        filter: filter,
        height: height,
        width: width,
      );
      const saveToAlbum = "action_buttons.save_to_album";
      const saveToDevice = "action_buttons.save_to_device";

      await tester.pumpWidget(
          OffsetProvider(child: MaterialApp(home: Builder(builder: (context) {
        OffsetProvider.of(context).setOffset(context);
        return CatEditorPage(
          cat: kitty,
        );
      }))));

      await tester.pump();
      final findAppBar = find.descendant(
          of: find.byType(Scaffold), matching: find.byType(CustomAppbar));
      final findSaveCatButtonAction = find.descendant(
          of: find.byType(Scaffold), matching: find.byType(SaveCatButton));
      final findIconButtons = find.descendant(
          of: find.byType(Scaffold), matching: find.byType(IconButton));

      expect(findAppBar, findsOneWidget);
      expect(findSaveCatButtonAction, findsOneWidget);
      expect(findIconButtons, findsWidgets);

      await tester.tap(find.byType(SaveCatButton));
      await tester.pump();

      final findSaveToAlbumAction = find.descendant(
          of: find.byType(Scaffold), matching: find.text(saveToAlbum));
      final findSaveToDeviceAction = find.descendant(
          of: find.byType(Scaffold), matching: find.text(saveToDevice));
      expect(findSaveToAlbumAction, findsOneWidget);
      expect(findSaveToDeviceAction, findsOneWidget);
    });

    // group("Dropdown popup test", () {
    //   testWidgets("Render test", (tester) async {
    //     await tester.pumpWidget(
    //       OffsetProvider(
    //         child: MaterialApp(
    //           home: Builder(builder: (context) {
    //             OffsetProvider.of(context).setOffset(context);
    //             return FakeWidget(
    //               items: [
    //                 DropdownItem(value: "ads", child: Text("rrewrw")),
    //                 DropdownItem(
    //                     value: "adskfsa;]\\\\213-01fjdsklfasl;\\\\\\",
    //                     child: Text("jfks;j")),
    //                 DropdownItem(value: "qew", child: Text("q")),
    //               ],
    //             );
    //           }),
    //           theme: ThemeData.light(),
    //         ),
    //       ),
    //     );

    //     final findIfRenders = find.byType(FakeWidget);
    //     expect(findIfRenders, findsOneWidget);

    //     final kek = find.byType(IconButton);
    //     expect(kek, findsOneWidget);

    //     await tester.tap(kek);
    //     await tester.pump();

    //     // final findIfRendersAfter = find.byType(DropdownPopup);
    //     // expect(findIfRendersAfter, findsOneWidget);
    //     final findItemByText = find.text("rrewrw");
    //     expect(findItemByText, findsOneWidget);

    //     await tester.tap(findItemByText);
    //     await tester.pumpAndSettle();

    //     final findQ = find.text("q");
    //     expect(findQ, findsNothing);
      });

      // testWidgets("string type", (tester) async {
      //   await tester.pumpWidget(MaterialApp(home: FakeWidget(
      //     items: [
      //       DropdownItem(value: "ads", child: Text("rrewrw")),
      //       DropdownItem(value: "adskfsa;]\\\\213-01fjdsklfasl;\\\\\\", child: Text("jfks;j")),
      //       DropdownItem(value: "qew", child: Text("q")),
      //     ],
      //   )));

      //   final findIfRenders = find.byType(FakeWidget);
      //   expect(findIfRenders, findsOneWidget);

      //   final kek = find.byType(IconButton);
      //   expect(kek, findsOneWidget);

      //   await tester.tap(kek);
      //   await tester.pump();

      //   final findFirst = find.text("rrewrw");
      //   final findFirstRes = find.text("ads");

      //   final findSecond = find.text("q");
      //   final findSecondRes = find.text("adskfsa;]\\\\213-01fjdsklfasl;\\\\\\");

      //   expect(findFirst, findsOneWidget);
      //   expect(findFirstRes, findsNothing);
      //   expect(findSecondRes, findsNothing);
      //   expect(findSecond, findsOneWidget);

      //   await tester.tap(find.text("rrewrw"));
      //   await tester.pump();

      //   final findThird = find.descendant(of: find.byType(DropdownItem), matching: find.text("jfks;j"));
      //   final findThirdRes = find.descendant(
      //     of: find.byType(DropdownItem),
      //     matching: find.text("adskfsa;]\\\\213-01fjdsklfasl;\\\\\\")
      //   );

      //   expect(findThird, findsNothing);
      //   expect(findThirdRes, findsNothing);
      // });

      // testWidgets("int type", (tester) async {
      //   await tester.pumpWidget(MaterialApp(home: FakeWidget(
      //     items: [
      //       DropdownItem(value: 132312, child: Text("rrewrw")),
      //       DropdownItem(value: -14123, child: Text("jfks;j")),
      //       DropdownItem(value: 0, child: Text("q")),
      //     ],
      //   )));

      //   final findIfRenders = find.byType(FakeWidget);
      //   expect(findIfRenders, findsOneWidget);

      //   final kek = find.byType(IconButton);
      //   expect(kek, findsOneWidget);

      //   await tester.tap(kek);
      //   await tester.pump();
      //   final findFirst = find.text("rrewrw");
      //   final findFirstRes = find.text("ads");

      //   final findSecond = find.text("q");
      //   final findSecondRes = find.text("-14123");

      //   expect(findFirst, findsOneWidget);
      //   expect(findFirstRes, findsNothing);
      //   expect(findSecondRes, findsNothing);
      //   expect(findSecond, findsOneWidget);

      //   await tester.tap(find.text("rrewrw"));
      //   await tester.pump();

      //   final findThird = find.text("jfks;j");
      //   final findThirdRes = find.text("q");

      //   expect(findThird, findsNothing);
      //   expect(findThirdRes, findsNothing);
      // });

      // testWidgets("Cat type", (tester) async {
      //   await tester.pumpWidget(MaterialApp(home: FakeWidget(
      //     items: [
      //       DropdownItem(value: 132312, child: Text("rrewrw")),
      //       DropdownItem(value: -14123, child: Text("jfks;j")),
      //       DropdownItem(value: 0, child: Text("q")),
      //     ],
      //   )));

      //   final findIfRenders = find.byType(FakeWidget);
      //   expect(findIfRenders, findsOneWidget);

      //   final kek = find.byType(IconButton);
      //   expect(kek, findsOneWidget);

      //   await tester.tap(kek);
      //   await tester.pump();

      //   final findFirst = find.text("rrewrw");
      //   final findFirstRes = find.text("ads");

      //   final findSecond = find.text("q");
      //   final findSecondRes = find.text("-14123");

      //   expect(findFirst, findsOneWidget);
      //   expect(findFirstRes, findsNothing);
      //   expect(findSecondRes, findsNothing);
      //   expect(findSecond, findsOneWidget);

      //   await tester.tap(find.text("rrewrw"));
      //   await tester.pump();

      //   final findThird = find.text("jfks;j");
      //   final findThirdRes = find.text("q");

      //   expect(findThird, findsNothing);
      //   expect(findThirdRes, findsNothing);
      // });
    // });
  // });

  group("Unit tests", () {
    test("Test Cat class", () {
      final cat = FakeCatRepository().getCatWithAdditionalParams(
        textColor: "red",
        text: "well, this is text",
        fontSize: 30.21,
        filter: null,
        height: null,
        width: 124,
      );

      expect(
          cat.url,
          baseUrl +
              "/cat/0/says/well, this is text?filter=&color=red&type=&size=30.21&height=&width=124.0");
      expect(
          cat.copyWith(id: "32132").url,
          baseUrl +
              "/cat/32132/says/well, this is text?filter=&color=red&type=&size=30.21&height=&width=124.0");
      expect(
          cat.copyWith(id: "", text: "").url,
          baseUrl +
              "/cat/?filter=&color=red&type=&size=30.21&height=&width=124.0");
    });
  });
}
