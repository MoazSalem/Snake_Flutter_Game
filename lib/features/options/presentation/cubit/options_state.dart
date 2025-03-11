part of 'options_cubit.dart';

class OptionsState {
  final int controllerStyle;
  final int boardHeight;
  final int boardWidth;

  OptionsState(
      {required this.boardHeight,
      required this.boardWidth,
      required this.controllerStyle});

  OptionsState copyWith({
    int? controllerStyle,
    int? boardHeight,
    int? boardWidth,
  }) {
    return OptionsState(
      boardHeight: boardHeight ?? this.boardHeight,
      boardWidth: boardWidth ?? this.boardWidth,
      controllerStyle: controllerStyle ?? this.controllerStyle,
    );
  }
}
