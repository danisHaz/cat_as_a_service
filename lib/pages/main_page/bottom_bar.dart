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
	BottomBarDataState();
	set _currentIndex(int index) {
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
			_currentIndex = newIndex;
		});
	}

	@override
	Widget build(BuildContext context) {
		return BottomNavigationBar(
			items: [
				BottomNavigationBarItem(
					label: "Feed",
					icon: Image.asset("assets/images/feed.png"),
				),
				BottomNavigationBarItem(
					label: "Add a cat",
					icon: Image.asset("assets/images/add.png"),
				),
				BottomNavigationBarItem(
					label: "Albums",
					icon: Image.asset("assets/images/albums.png"),
				),
			]
		);
		
	}
}