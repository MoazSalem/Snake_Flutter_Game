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
    controllerStyle = getIt.get<Box>().get('controllerStyle') ?? 1;
    boardWidth = getIt.get<Box>().get('boardWidth') ?? (getIt.get<Size>().width * 0.036).toInt();
    boardHeight =
        getIt.get<Box>().get('boardHeight') ?? ((getIt.get<Size>().width * 0.036) * 1.7).toInt();
  }

  resetSize() {
    boardWidth = (getIt.get<Size>().width * 0.036).toInt();
    boardHeight = ((getIt.get<Size>().width * 0.036) * 1.7).toInt();
    emit(OptionsChanged());
  }

  saveSize() {
    getIt.get<Box>().put('boardHeight', boardHeight);
    getIt.get<Box>().put('boardWidth', boardWidth);
    emit(OptionsChanged());
  }

  changeControllerStyle(int style) {
    controllerStyle = style;
    getIt.get<Box>().put('controllerStyle', controllerStyle);
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
