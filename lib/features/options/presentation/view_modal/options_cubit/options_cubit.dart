import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:snake/core/utils/service_locator.dart';

part 'options_state.dart';

class OptionsCubit extends Cubit<OptionsState> {
  OptionsCubit() : super(OptionsInitial());
  static OptionsCubit get(context) => BlocProvider.of(context);

  late int controllerStyle;
  late int boardWidth;
  late int boardHeight;

  getSettings() {
    controllerStyle = Hive.box('optionsBox').get('controllerStyle') ?? 1;
    boardWidth =
        Hive.box('optionsBox').get('boardWidth') ?? (getIt.get<Size>().width * 0.036).toInt();
    boardHeight = Hive.box('optionsBox').get('boardHeight') ??
        ((getIt.get<Size>().width * 0.036) * 1.7).toInt();
  }

  resetSize() {
    boardWidth = (getIt.get<Size>().width * 0.036).toInt();
    boardHeight = ((getIt.get<Size>().width * 0.036) * 1.7).toInt();
    emit(OptionsChanged());
  }

  saveSize() {
    Hive.box('optionsBox').put('boardHeight', boardHeight);
    Hive.box('optionsBox').put('boardWidth', boardWidth);
    emit(OptionsChanged());
  }

  changeControllerStyle(int style) {
    controllerStyle = style;
    Hive.box('optionsBox').put('controllerStyle', controllerStyle);
    emit(OptionsChanged());
  }

  changeHeight(int type) {
    if (type == 1) {
      boardHeight = boardHeight + 1;
    } else {
      boardHeight = boardHeight - 1;
    }
    emit(OptionsChanged());
  }

  changeWidth(int type) {
    if (type == 1) {
      boardWidth = boardWidth + 1;
    } else {
      boardWidth = boardWidth - 1;
    }
    emit(OptionsChanged());
  }
}
