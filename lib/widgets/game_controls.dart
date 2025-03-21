import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io' show Platform;
import '../blocs/game/game_bloc.dart';
import '../blocs/game/game_event.dart';

class GameControls extends StatelessWidget {
  const GameControls({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final buttonHeight = isLandscape ? 35.0 : 40.0;
    final sliderWidth = isLandscape ? screenSize.width * 0.15 : screenSize.width * 0.8;
    final fontSize = isLandscape ? 12.0 : 14.0;

    return _GameControlsLayout(
      screenSize: screenSize,
      isLandscape: isLandscape,
      buttonHeight: buttonHeight,
      sliderWidth: sliderWidth,
      fontSize: fontSize,
    );
  }
}

class _GameControlsLayout extends StatelessWidget {
  final Size screenSize;
  final bool isLandscape;
  final double buttonHeight;
  final double sliderWidth;
  final double fontSize;

  const _GameControlsLayout({
    required this.screenSize,
    required this.isLandscape,
    required this.buttonHeight,
    required this.sliderWidth,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSlider(context),
        _buildButtons(context),
      ],
    );
  }

  Widget _buildSlider(BuildContext context) {
    final bet = context.watch<GameBloc>().state.game.bet;
    
    return SizedBox(
      width: sliderWidth,
      child: Platform.isIOS
          ? CupertinoSlider(
              value: bet.toDouble(),
              min: 1,
              max: 5,
              divisions: 4,
              onChanged: (value) => _updateBet(context, value),
            )
          : Slider(
              value: bet.toDouble(),
              min: 1,
              max: 5,
              divisions: 4,
              label: 'Betting: $bet point${bet > 1 ? 's' : ''}',
              onChanged: (value) => _updateBet(context, value),
            ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton(
          context,
          'Roll Dice',
          () => context.read<GameBloc>().add(RollDiceEvent()),
          isPrimary: true,
        ),
        _buildButton(
          context,
          'Reset Game',
          () => context.read<GameBloc>().add(ResetGameEvent()),
          isPrimary: false,
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context, String text, VoidCallback onPressed, {bool isPrimary = true}) {
    return SizedBox(
      height: buttonHeight,
      child: Platform.isIOS
          ? CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              minSize: buttonHeight,
              onPressed: onPressed,
              color: isPrimary ? CupertinoColors.activeBlue : null,
              child: Text(text, style: TextStyle(fontSize: fontSize)),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: fontSize),
              ),
              onPressed: onPressed,
              child: Text(text),
            ),
    );
  }

  void _updateBet(BuildContext context, double value) {
    context.read<GameBloc>().add(Updatebet(value.round()));
  }
}
