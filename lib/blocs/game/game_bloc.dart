import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'game_event.dart';
import 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameInitial()) {
    on<RollDiceEvent>(_onRollDice);
    on<ResetGameEvent>(_onResetGame);
    on<Updatebet>(_onUpdateBet);
  }
  
  final Random _random = Random();
  static const int winScore = 20;

  void _onRollDice(RollDiceEvent event, Emitter<GameState> emit) {
    if (state is GameOver) {
      emit(GameOver(
        game: state.game,
        playerWon: state.game.playerScore >= winScore,
        message: 'Game is over! Please reset to start a new game.',
      ));
      return;
    }

    final playerDie1 = _random.nextInt(6) + 1;
    final playerDie2 = _random.nextInt(6) + 1;
    final computerDie1 = _random.nextInt(6) + 1;
    final computerDie2 = _random.nextInt(6) + 1;
    
    final newPlayerDice = [playerDie1, playerDie2];
    final newComputerDice = [computerDie1, computerDie2];
    
    final playerProduct = newPlayerDice[0] * newPlayerDice[1];
    final computerProduct = newComputerDice[0] * newComputerDice[1];
    
    final newGame = state.game.copyWith(
      playerDice: newPlayerDice,
      computerDice: newComputerDice,
      playerScore: state.game.playerScore + 
          (playerProduct > computerProduct ? state.game.bet : 0),
      computerScore: state.game.computerScore + 
          (computerProduct > playerProduct ? state.game.bet : 0),
      roundNumber: state.game.roundNumber + 1,
    );

    if (newGame.playerScore >= winScore || newGame.computerScore >= winScore) {
      emit(GameOver(
        game: newGame,
        playerWon: newGame.playerScore >= winScore,
        message: '🎉 Congratulations! ${newGame.playerScore >= winScore ? "Player" : "Computer"} won the game!\n\nPress "Reset Game" to play again.',
      ));
    } else {
      emit(RoundComplete(
        game: newGame,
        playerWonRound: playerProduct > computerProduct,
        message: playerProduct > computerProduct 
            ? 'You won this round!'
            : playerProduct < computerProduct 
                ? 'Computer won this round!'
                : 'It\'s a tie!',
      ));
    }
  }

  void _onResetGame(ResetGameEvent event, Emitter<GameState> emit) {
    emit(const GameInitial());
  }

  void _onUpdateBet(Updatebet event, Emitter<GameState> emit) {
    final newGame = state.game.copyWith(bet: event.bet);
    emit(GameInProgress(game: newGame));
  }
}
