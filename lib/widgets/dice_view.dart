import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/game/game_bloc.dart';
import '../blocs/game/game_state.dart';

class DiceView extends StatelessWidget {
  final bool isPlayer;

  const DiceView({super.key, required this.isPlayer});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;

    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        final diceValues = isPlayer ? state.game.playerDice : state.game.computerDice;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isPlayer ? 'Player' : 'Computer',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _DiceImage(
                    value: diceValues[0],
                    size: isLandscape ? 50.0 : 70.0,
                  ),
                  const SizedBox(width: 10),
                  _DiceImage(
                    value: diceValues[1],
                    size: isLandscape ? 50.0 : 70.0,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Product: ${diceValues[0] * diceValues[1]}',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DiceImage extends StatelessWidget {
  final int value;
  final double size;

  const _DiceImage({
    required this.value,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 3,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          'assets/dice$value.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
