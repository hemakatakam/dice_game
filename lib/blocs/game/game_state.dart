import '../../models/game_model.dart';

enum GameStatus {
  initial,
  inProgress,
  roundComplete,
  gameOver
}

abstract class GameState {
  final Game game;
  
  const GameState({required this.game});
}

class GameInitial extends GameState {
  const GameInitial() : super(game: const Game());
}

class GameInProgress extends GameState {
  const GameInProgress({required Game game}) : super(game: game);
}

class RoundComplete extends GameState {
  final String message;
  final bool playerWonRound;

  const RoundComplete({
    required Game game,
    required this.message,
    required this.playerWonRound,
  }) : super(game: game);
}

class GameOver extends GameState {
  final bool playerWon;
  final String message;

  const GameOver({
    required Game game,
    required this.playerWon,
    required this.message,
  }) : super(game: game);
}
