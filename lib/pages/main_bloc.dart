import 'package:flutter_basics_2/shared/bottom_bar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MainCubit extends Cubit<BottomBarState> {
  MainCubit(): super(BottomBarState.feedScreen());

  void changeState(BottomBarState state) {
    emit(state);
  }
}