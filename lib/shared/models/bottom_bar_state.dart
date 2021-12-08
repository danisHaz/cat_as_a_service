import 'dart:developer';

class BottomBarState {
	const BottomBarState._();

	factory BottomBarState.error(Error e) => BottomBarErrorState(e);
	factory BottomBarState.feedScreen() => const BottomBarFeedState();
	factory BottomBarState.addCatScreen() => BottomBarAddCatState();
	factory BottomBarState.albumsScreen() => BottomBarAlbumsState();
}

class BottomBarErrorState extends BottomBarState {
	BottomBarErrorState(this._e): super._();

	final Error _e;

  Error get err => _e;

	void printError() {
		log("err stack trace: ${_e.stackTrace}");
	}
}

class BottomBarFeedState extends BottomBarState {
	const BottomBarFeedState(): super._();
}


class BottomBarAddCatState extends BottomBarState {
	BottomBarAddCatState(): super._();
}


class BottomBarAlbumsState extends BottomBarState {
	BottomBarAlbumsState(): super._();
}

class BottomBarSuccess extends BottomBarState {
	BottomBarSuccess(this.message): super._();

	final String message;
}