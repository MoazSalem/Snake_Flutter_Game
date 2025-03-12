import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:snake/core/utils/service_locator.dart';

part 'options_state.dart';

class OptionsCubit extends Cubit<OptionsState> {
  OptionsCubit()
      : super(OptionsState(boardHeight: 0, boardWidth: 0, controllerStyle: 0));
  static OptionsCubit get(context) => BlocProvider.of(context);
  getSettings() {
    emit(state.copyWith(
      boardHeight: Hive.box('optionsBox').get('boardHeight') ??
          ((getIt.get<Size>().width * 0.036) * 1.7).toInt(),
      boardWidth: Hive.box('optionsBox').get('boardWidth') ??
          (getIt.get<Size>().width * 0.036).toInt(),
      controllerStyle: Hive.box('optionsBox').get('controllerStyle') ?? 1,
    ));
  }

  resetSize() {
    emit(state.copyWith(
      boardWidth: (getIt.get<Size>().width * 0.036).toInt(),
      boardHeight: ((getIt.get<Size>().width * 0.036) * 1.7).toInt(),
    ));
  }

  saveSize() {
    Hive.box('optionsBox').put('boardHeight', state.boardHeight);
    Hive.box('optionsBox').put('boardWidth', state.boardWidth);
    emit(state);
  }

  changeControllerStyle(int style) {
    emit(state.copyWith(controllerStyle: style));
    Hive.box('optionsBox').put('controllerStyle', state.controllerStyle);
  }

  changeHeight(int type) {
    emit(state.copyWith(
        boardHeight:
            type == 1 ? state.boardHeight + 1 : state.boardHeight - 1));
  }

  changeWidth(int type) {
    emit(state.copyWith(
        boardWidth: type == 1 ? state.boardWidth + 1 : state.boardWidth - 1));
  }
}
