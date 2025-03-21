import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dice_view.dart';
import 'score_board.dart';
import 'game_controls.dart';
import '../blocs/game/game_bloc.dart';
import '../blocs/game/game_state.dart';

class GameLayout extends StatelessWidget {
  const GameLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listenWhen: (previous, current) => 
          current is RoundComplete || current is GameOver,
      listener: (context, state) {
        if (state is RoundComplete || state is GameOver) {
          if (Platform.isIOS) {
            _showCupertinoAlert(context, state);
          } else {
            _showMaterialAlert(context, state);
          }
        }
      },
      child: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? const _PortraitLayout()
              : const _LandscapeLayout();
        },
      ),
    );
  }

  void _showMaterialAlert(BuildContext context, GameState state) {
    final message = state is GameOver ? state.message : (state as RoundComplete).message;
    final color = state is GameOver 
        ? (state.playerWon ? Colors.green : Colors.red)
        : (state as RoundComplete).playerWonRound ? Colors.blue : Colors.grey;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: Text('Game Alert', style: TextStyle(color: color)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showCupertinoAlert(BuildContext context, GameState state) {
    final message = state is GameOver ? state.message : (state as RoundComplete).message;
    final color = state is GameOver 
        ? (state.playerWon ? CupertinoColors.systemGreen : CupertinoColors.systemRed)
        : (state as RoundComplete).playerWonRound ? CupertinoColors.systemBlue : CupertinoColors.systemGrey;

    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Game Alert', style: TextStyle(color: color)),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class _PortraitLayout extends StatelessWidget {
  const _PortraitLayout();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final spacing = screenSize.height * 0.02;

    return Column(
      children: [
        const ScoreBoard(),
        SizedBox(height: spacing),
        const Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DiceView(isPlayer: true),
              DiceView(isPlayer: false),
            ],
          ),
        ),
        SizedBox(height: spacing),
        const GameControls(),
      ],
    );
  }
}

class _LandscapeLayout extends StatelessWidget {
  const _LandscapeLayout();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final padding = screenSize.width * 0.02;
    final spacing = screenSize.width * 0.015;

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              const ScoreBoard(),
              SizedBox(height: spacing),
              const GameControls(),
              SizedBox(height: padding),
            ],
          ),
        ),
        SizedBox(width: spacing),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              const Expanded(child: DiceView(isPlayer: true)),
              SizedBox(width: spacing),
              const Expanded(child: DiceView(isPlayer: false)),
            ],
          ),
        ),
      ],
    );
  }
}
