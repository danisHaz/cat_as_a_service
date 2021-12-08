import 'dart:developer';

class BottomBarState {
	BottomBarState._();

	factory BottomBarState.error(Error e) => BottomBarError(e);
	factory BottomBarState.feedScreen() => BottomBarFeedState();
	factory BottomBarState.addCatScreen() => BottomBarAddCatState();
	factory BottomBarState.albumsScreen() => BottomBarAlbumsState();
}

class BottomBarError extends BottomBarState {
	BottomBarError(this._e): super._();

	final Error _e;

	void printError() {
		log("err stack trace: ${_e.stackTrace}");
	}
}

class BottomBarFeedState extends BottomBarState {
	BottomBarFeedState(): super._();
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