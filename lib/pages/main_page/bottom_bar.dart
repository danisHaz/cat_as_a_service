import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_basics_2/shared/models/bottom_bar_state.dart';

class BottomBar extends StatefulWidget {
	
	const BottomBar({Key? key}): super(key: key);

	@override
	BottomBarDataState createState() => BottomBarDataState();
}

class BottomBarDataState extends State<BottomBar> {
	// Default state is feed screen with scrollable list of cats
	BottomBarState _currentState = BottomBarState.feedScreen();
  int _currentIndex = 0;
  
  int get currentIndex => _currentIndex;
	void set currentIndex(int index) {
		switch(index) {
			case 0:
				_currentState = BottomBarState.feedScreen();
				break;
			case 1:
				_currentState = BottomBarState.addCatScreen();
				break;
			case 2:
				_currentState = BottomBarState.albumsScreen();
				break;
		}
    _currentIndex = index;
	}

	void _onItemSelected(int newIndex) {
		setState(() {
			currentIndex = newIndex;
		});
	}

	@override
	Widget build(BuildContext context) {
		return BottomNavigationBar(
			items: <BottomNavigationBarItem>[
				BottomNavigationBarItem(
					label: 'bottom_bar.feed'.tr(),
					icon: Image.asset("assets/images/feed.png"),
				),
				BottomNavigationBarItem(
					label: "bottom_bar.add_a_cat".tr(),
					icon: Image.asset("assets/images/add.png"),
				),
				BottomNavigationBarItem(
					label: "bottom_bar.albums".tr(),
					icon: Image.asset("assets/images/albums.png"),
				),
			],
      onTap: _onItemSelected,
      currentIndex: _currentIndex,
      selectedItemColor: Colors.purple,
		);
		
	}
}